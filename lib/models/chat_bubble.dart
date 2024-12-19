import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String mesage;
  const ChatBubble({super.key, required this.mesage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue
      ),
      child: Text(
        mesage,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
      ),
    );
  }
}
