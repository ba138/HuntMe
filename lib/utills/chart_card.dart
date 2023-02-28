import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/utills/loader.dart';
import 'package:intl/intl.dart';
import '../tab/chat/controller/chat_controller.dart';
import '../tab/chat/screens/mobile_chat_screen.dart';

class ChatCard extends ConsumerStatefulWidget {
  const ChatCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatCardState();
}

class _ChatCardState extends ConsumerState<ChatCard> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .snapshots(),
      // ref.watch(chatControllerProvider).getContactsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Loader(),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('No Chats to Show'),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            var notificationData = snapshot.data!.docs[index];

            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                notificationData['timeSend']);
            var timeSent = DateFormat.Hm().format(dateTime);

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 206, 201, 201)
                        .withOpacity(0.2)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => MobileChatScreen(
                                bio: notificationData['bio'],
                                name: notificationData['name'],
                                profilePic: notificationData['profilePic'],
                                uid: notificationData['userId'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(
                                    notificationData['profilePic'],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notificationData['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      notificationData['text'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              timeSent,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
