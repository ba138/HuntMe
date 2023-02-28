import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hunt_me/Models/job_model.dart';
import 'package:hunt_me/Models/user_model.dart';
import 'package:uuid/uuid.dart';

final jobRepository = Provider(
  (ref) => JobRepository(
      fireStore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class JobRepository {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  JobRepository({required this.fireStore, required this.auth});
  void _notificationData(
    String title,
    String profilePic,
    DateTime timePost,
    String postId,
  ) async {
    // var notificationData = NotificationModel(
    //   title: title,
    //   userId: auth.currentUser!.uid,
    //   profilePic: profilePic,
    //   timePost: timePost,
    //   notificationId: postId,
    // );
  }

  void postJob(
    String gigs,
    String title,
    String jobType,
    String location,
    String industry,
    String discrption,
  ) async {
    try {
      var postId = const Uuid().v1();
      var timePost = DateTime.now();
      var userDataById =
          await fireStore.collection('users').doc(auth.currentUser!.uid).get();
      var userData = UserModel.fromMap(userDataById.data()!);
      var jobData = JobModel(
        gigs: gigs,
        title: title,
        discrption: discrption,
        jobType: jobType,
        location: location,
        industry: industry,
        userId: userData.uid,
        profilePic: userData.profilePic,
        bio: userData.bio,
        postTime: timePost,
        name: userData.name,
        postId: postId,
      );
      await fireStore.collection('post').doc(postId).set(
            jobData.toMap(),
          );
      await fireStore
          .collection('Notification')
          .doc(postId)
          .set(jobData.toMap());
      await fireStore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('mypost')
          .doc(postId)
          .set(jobData.toMap());
      // ignore: use_build_context_synchronously
      _notificationData(title, userData.profilePic, timePost, postId);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Stream<UserModel> getUserData() {
    return fireStore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  Stream<List<JobModel>> myPost() {
    return fireStore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('mypost')
        .snapshots()
        .map((event) {
      List<JobModel> jobData = [];
      for (var documents in event.docs) {
        jobData.add(
          JobModel.fromMap(
            documents.data(),
          ),
        );
      }
      return jobData;
    });
  }
}
