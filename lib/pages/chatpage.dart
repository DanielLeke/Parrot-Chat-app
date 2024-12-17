import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const Chatpage(
    {
      super.key,
      required this.receiverUserEmail,
      required this.receiverUserId
    }
  );

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
        foregroundColor: Colors.blue,
        backgroundColor: Colors.blue,
        title: Text(widget.receiverUserEmail),
      ),
    );
  }
}
