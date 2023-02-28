import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/user_model.dart';

import '../../../Models/job_model.dart';

final discoverRepository = Provider(
  (ref) => DiscoverRepository(
      fireStore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class DiscoverRepository {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  DiscoverRepository({required this.fireStore, required this.auth});

  Stream<List<UserModel>> getService() {
    return fireStore.collection('users').snapshots().map((event) {
      List<UserModel> userData = [];
      for (var documents in event.docs) {
        userData.add(
          UserModel.fromMap(
            documents.data(),
          ),
        );
      }
      return userData;
    });
  }

  Stream<QuerySnapshot> searchQuery(String query) {
    return fireStore
        .collection('post')
        .where('title', isEqualTo: query)
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query)
        .snapshots();
  }
}
