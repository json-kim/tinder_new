import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tinder_new/data/db/remote/response.dart';
import 'package:tinder_new/data/provider/user_provider.dart';
import 'package:tinder_new/ui/screens/register_with_social_screen.dart';
import 'package:tinder_new/ui/screens/top_navigation_screen.dart';
import 'package:tinder_new/util/constants.dart';
import 'package:tinder_new/ui/widgets/app_image_with_text.dart';
import 'package:tinder_new/ui/screens/login_screen.dart';
import 'package:tinder_new/ui/screens/register_screen.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

const List<String> scopes = ['email', 'profile'];

class StartScreen extends StatefulWidget {
  static const String id = 'start_screen';

  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen(_handleGoogleAccountStateChanged);

    // 자동 로그인 (주석)
    // _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> _handleGoogleAccountStateChanged(
      GoogleSignInAccount? account) async {
    // In mobile, being authenticated means being authorized...
    bool isAuthorized = account != null;
    // However, in the web...
    if (kIsWeb && account != null) {
      isAuthorized = await _googleSignIn.canAccessScopes(scopes);
    }

    // 권한 없을 경우, 권한 요청
    if (!isAuthorized) {
      isAuthorized = await _googleSignIn.requestScopes(scopes);
    }

    // 그래도 권한 없으면 리턴
    if (!isAuthorized) return;

    // 파이어스토어에서 유저 데이터 있는지 확인
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authResponse = await userProvider.loginWithGoogle(account!);

    if (authResponse is! Success<UserCredential>) return;

    final user = await userProvider.user;
    // 없으면 등록화면, 있으면, 홈화면 이동

    if (user != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(TopNavigationScreen.id, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RegisterWithSocialScreen.id, (route) => false,
          arguments: {
            'social_user_email': account.email,
            'social_user_name': account.displayName,
            'social_user_profile_photo_url': account.photoUrl ?? '',
            'credential_id': authResponse.value.user?.uid ?? '',
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: Container(
            margin: const EdgeInsets.only(bottom: 40, top: 120),
            child: Column(
              children: [
                AppIconTitle(),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Lorel ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Nulla in orci justo. Curabitur ac gravida quam.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
                const SizedBox(height: 20),
                (GoogleSignInPlatform.instance as web.GoogleSignInPlugin)
                    .renderButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
