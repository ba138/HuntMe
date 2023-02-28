import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/utills/loader.dart';
import 'package:hunt_me/utills/sender_message_card.dart';
import 'package:intl/intl.dart';

import 'my_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String uid;
  const ChatList({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(widget.uid)
          .collection('messages')
          .snapshots(),
      //  ref.watch(chatControllerProvider).getMessage(widget.uid)
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Loader(),
          );
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageController.jumpTo(messageController.position.maxScrollExtent);
        });
        if (!snapshot.hasData) {
          return const Text('Data to show');
        }
        // }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            var notificationData = snapshot.data!.docs[index];

            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                notificationData['timeSent']);

            var timeSent = DateFormat.Hm().format(dateTime);
            // var timeSent =
            //     DateFormat.Hm().format(notificationData['timeSent']);
            if (FirebaseAuth.instance.currentUser!.uid ==
                notificationData['senderId']) {
              return MyMessageCard(
                text: notificationData['text'],
                time: timeSent,
                messageId: notificationData['messageId'],
                receiverId: notificationData['recieverId'],
              );
            }
            return SenderMessageCard(
              text: notificationData['text'],
              time: timeSent,
            );
          },
        );
      },
    );
  }
}
