// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Models/user_model.dart';
import '../../home/home.dart';
import '../../utills/common_firebase_storage.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  void createUser(String email, String password, {required String bio}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void saveDataToFireStore({
    required String name,
    required String bio,
    required String email,
    required String phoneNumber,
    required File? profile,
    required BuildContext context,
    required ProviderRef ref,
    required String password,
  }) async {
    try {
      String photourl =
          'https://nakedsecurity.sophos.com/wp-content/uploads/sites/2/2013/08/facebook-silhouette_thumb.jpg';

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = auth.currentUser!.uid;
      if (profile != null) {
        photourl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFileFileToFirebase('profilPic/$uid', profile);
      }
      var userData = UserModel(
        name: name,
        uid: uid,
        profilePic: photourl,
        email: email,
        bio: bio,
        phoneNumber: phoneNumber,
      );
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(userData.toMap());
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (c) => const Home(),
          ),
          (route) => false);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  void loginUser(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (c) => const Home()), (route) => false);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Future<UserModel?> checkUser() async {
    var userCollection =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userCollection.data() != null) {
      user = UserModel.fromMap(userCollection.data()!);
    }
    return user;
  }
}
