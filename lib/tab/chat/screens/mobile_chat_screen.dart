import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/utills/message_list.dart';

import '../../../utills/bottom_chat_bar.dart';

class MobileChatScreen extends ConsumerStatefulWidget {
  final String profilePic;
  final String uid;
  final String name;
  final String bio;
  const MobileChatScreen(
      {super.key,
      required this.bio,
      required this.name,
      required this.profilePic,
      required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_outlined)),
                      CircleAvatar(
                          backgroundImage: NetworkImage(widget.profilePic),
                          radius: 24),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.bio,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert_outlined),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(child: ChatList(uid: widget.uid)),
              // SizedBox(height: MediaQuery.of(context).size.height / 8 / 2),
              // SizedBox(height: MediaQuery.of(context).size.height / 8 / 2),
              BottomBar(
                uid: widget.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
