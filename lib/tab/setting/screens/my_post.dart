import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mypost_card.dart';

class MyPost extends ConsumerStatefulWidget {
  const MyPost({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPostState();
}

class _MyPostState extends ConsumerState<MyPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Post',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: const [MyPostCard()],
            ),
          ),
        )));
  }
}
