import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../tab/chat/controller/chat_controller.dart';
import 'colors.dart';

class BottomBar extends ConsumerStatefulWidget {
  final String uid;
  const BottomBar({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  final TextEditingController bootomBarTextEditingController =
      TextEditingController();
  FocusNode focusNode = FocusNode();

  void sendTextMessage() {
    ref.read(chatControllerProvider).sendTextMessage(
        widget.uid, bootomBarTextEditingController.text.trim());

    ref.read(chatControllerProvider).saveMessage(
          widget.uid,
          bootomBarTextEditingController.text.trim(),
        );
    setState(() {
      bootomBarTextEditingController.text = '';
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: bootomBarTextEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type here',
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
              onTap: sendTextMessage,
              child: const Icon(
                Icons.send,
                color: buttonColor,
                size: 30,
              ))

          // icon: const Icon(
          //   Icons.send,
          //   color: buttonColor,
          //   size: 30,
          // ),
        ],
      ),
    );
  }
}
