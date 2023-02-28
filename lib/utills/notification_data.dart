import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/utills/loader.dart';
import 'package:intl/intl.dart';

import '../tab/chat/screens/mobile_chat_screen.dart';
import 'colors.dart';

class NotificationData extends ConsumerWidget {
  final String postId;
  const NotificationData({super.key, required this.postId});
  String dateFormat(Timestamp postTime) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(postTime.seconds * 1000);
    return DateFormat().format(dateTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('post')
            .doc(postId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Loader(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data To show'),
            );
          }
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4 / 2,
                width: MediaQuery.of(context).size.width / 0.5 / 2,
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 206, 201, 201).withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                snapshot.data!['jobType'],
                              ),
                              const Icon(
                                Icons.location_on,
                              ),
                              Text(
                                snapshot.data!['location'],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(dateFormat(snapshot.data!['postTime'])),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid ==
                                  snapshot.data!['userId']
                              ? Container(
                                  color: Colors.transparent,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (c) => MobileChatScreen(
                                          bio: snapshot.data!['bio'],
                                          name: snapshot.data!['name'],
                                          profilePic:
                                              snapshot.data!['profilePic'],
                                          uid: snapshot.data!['userId'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: buttonColor,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Chat',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.5 / 2,
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 206, 201, 201).withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        snapshot.data!['discrption'],
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        });
  }
}
