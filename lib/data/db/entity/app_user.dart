import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_new/data/model/enum/sexual_orientation.dart';

class AppUser {
  String id;
  String name;
  int age;
  String profilePhotoPath;
  SexualOrientation sexualOrientation;
  String bio = "";

  AppUser({
    required this.id,
    required this.name,
    required this.age,
    required this.profilePhotoPath,
    required this.sexualOrientation,
  });

  AppUser.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        age = snapshot['age'],
        profilePhotoPath = snapshot['profile_photo_path'],
        bio = snapshot.get('bio') ?? '',
        sexualOrientation = ((snapshot.data()
                as Map<String, dynamic>?)?['sexual_orientation'] as String?)
            .toSexualOrientation();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'profile_photo_path': profilePhotoPath,
      'bio': bio,
      'sexual_orientation': sexualOrientation.toEnString(),
    };
  }
}
