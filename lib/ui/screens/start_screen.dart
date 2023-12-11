import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinder_new/util/constants.dart';
import 'package:tinder_new/ui/widgets/app_image_with_text.dart';
import 'package:tinder_new/ui/screens/login_screen.dart';
import 'package:tinder_new/ui/screens/register_screen.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

const List<String> scopes = [
  'email',
];

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
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      account.

      // setState(() {
      //   _currentUser = account;
      //   _isAuthorized = isAuthorized;
      // });

      // // Now that we know that the user can access the required scopes, the app
      // // can call the REST API.
      // if (isAuthorized) {
      //   unawaited(_handleGetContact(account!));
      // }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
    super.initState();
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
