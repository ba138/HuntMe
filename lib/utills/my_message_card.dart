import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/tab/chat/controller/chat_controller.dart';

import 'package:hunt_me/utills/colors.dart';

class MyMessageCard extends ConsumerStatefulWidget {
  final String text;
  final String time;
  final String receiverId;
  final String messageId;
  const MyMessageCard(
      {Key? key,
      required this.text,
      required this.time,
      required this.messageId,
      required this.receiverId})
      : super(key: key);

  @override
  ConsumerState<MyMessageCard> createState() => _MyMessageCardState();
}

class _MyMessageCardState extends ConsumerState<MyMessageCard> {
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        setState(() {
          isDelete = true;
        });
      },
      child: isDelete
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Expanded(
                        child: Container(
                          // height: MediaQuery.of(context).size.height / 6 / 2,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: const BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.text,
                                  maxLines: 10,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.time,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          ref.watch(chatControllerProvider).deleteMessage(
                              widget.receiverId, widget.messageId);
                        },
                        child: const Text('Delete'))
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Expanded(
                    child: Container(
                      // height: MediaQuery.of(context).size.height / 6 / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.text,
                              maxLines: 10,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.time,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
