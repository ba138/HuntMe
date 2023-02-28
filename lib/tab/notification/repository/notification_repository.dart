import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/user_model.dart';

import '../../../Models/job_model.dart';

final notificationProvider = Provider((ref) => NotificationRepository(
    fireStore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class NotificationRepository {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  NotificationRepository({required this.fireStore, required this.auth});
  Stream<List<JobModel>> getNotification() {
    return fireStore.collection('Notification').snapshots().map((event) {
      List<JobModel> notificationData = [];
      for (var documents in event.docs) {
        notificationData.add(JobModel.fromMap(documents.data()));
      }
      return notificationData;
    });
  }

  // void saveNotification() async {
  //   var timePost = DateTime.now();
  //   String userId = auth.currentUser!.uid;
  //   var userDataById = await fireStore.collection('Post').get();
  //   var userData =JobModel.fromMap(userDataById.data.d)

  // }
  Stream<JobModel> getNotificationData(String postId) {
    return fireStore
        .collection('post')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map(
          (event) => JobModel.fromMap(
            event.data()!,
          ),
        );
  }
}
