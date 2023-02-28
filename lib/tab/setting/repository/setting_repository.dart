import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/job_model.dart';
import 'package:hunt_me/Models/user_model.dart';

import '../../../utills/common_firebase_storage.dart';

final settingRepositoryProvider = Provider(
  (ref) => SettingRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      ref: ref),
);

class SettingRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  SettingRepository(
      {required this.firestore, required this.auth, required this.ref});
  void logOutUser(BuildContext context) async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
  }

  void updateUserDetail(
      String name,
      String uid,
      File? profilePic,
      String phoneNumber,
      String bio,
      String email,
      BuildContext context) async {
    var userDataById =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    var userData = UserModel.fromMap(
      userDataById.data()!,
    );
    String photoUrl = userData.profilePic;
    if (profilePic != null) {
      photoUrl = await ref
          .read(commonFirebaseStorageProvider)
          .storeFileFileToFirebase('profilPic/$uid', profilePic);
    }
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          phoneNumber: phoneNumber,
          bio: bio,
          email: email,
        ).toMap());
    // ignore: use_build_context_synchronously
  }

  void deleteUser() async {
    await auth.currentUser?.delete();
    await firestore.collection('users').doc(auth.currentUser!.uid).delete();

    // ignore: use_build_context_synchronously
  }

  void deletePost(String jobid) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('mypost')
        .doc(jobid)
        .delete();
    await firestore.collection('post').doc(jobid).delete();
  }
}
