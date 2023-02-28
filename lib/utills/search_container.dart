import 'package:flutter/material.dart';

class KeyContainer extends StatefulWidget {
  final String title;
  const KeyContainer({super.key, required this.title});

  @override
  State<KeyContainer> createState() => _KeyContainerState();
}

class _KeyContainerState extends State<KeyContainer> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10 / 2,
      width: MediaQuery.of(context).size.width / 1.9 / 2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
