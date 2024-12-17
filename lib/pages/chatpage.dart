import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parrot/services/chat_service.dart';

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
  TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      _chatService.sendMessage(widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

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
