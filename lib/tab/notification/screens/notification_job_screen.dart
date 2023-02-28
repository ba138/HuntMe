import 'package:flutter/material.dart';

import '../../../utills/notification_data.dart';

// ignore: must_be_immutable
class NotificationJobScreen extends StatelessWidget {
  String postId;

  NotificationJobScreen({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Job',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(children: [
              NotificationData(
                postId: postId,
              )
            ])),
      ),
    );
  }
}
