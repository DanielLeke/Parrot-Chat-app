import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserEmail;
  final String receiverUserId;

  const Chatpage(
      {super.key,
      required this.receiverUserName,
      required this.receiverUserEmail,
      required this.receiverUserId});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: Text(
          widget.receiverUserName,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'DM Sans',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
