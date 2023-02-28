import 'package:flutter/material.dart';

class TextWithButton extends StatelessWidget {
  final String text;
  final Function() fun;
  const TextWithButton({super.key, required this.text, required this.fun});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
