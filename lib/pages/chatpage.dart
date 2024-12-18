import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _messageController = TextEditingController();
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
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: buildMessageInput(),
          ),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['message']),
        ],
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: 'Enter a message',
              hintStyle:
                  const TextStyle(fontFamily: "DM Sans", color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.blue, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 40,
              color: Colors.black,
            ))
      ],
    );
  }
}
