import 'dart:typed_data';

import 'package:tinder_new/data/model/enum/sexual_orientation.dart';

class UserRegistration {
  String name = '';
  int age = 0;
  String email = '';
  String password = '';
  SexualOrientation? sexualOrientation;
  Uint8List? profileBytes;
}
