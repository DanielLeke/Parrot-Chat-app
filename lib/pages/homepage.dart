import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parrot/pages/chatpage.dart';
import 'package:parrot/pages/signup.dart';
import 'package:parrot/services/auth_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                AuthService authService = AuthService();

                await authService.signout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Parrot',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'DM Sans',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }

  Widget buildUserList(DocumentSnapshot document) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("An error occurred");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.blue,
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            return _buildUserListItem(doc);
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chatpage(
                      receiverUserEmail: data['email'],
                      receiverUserId: data['uid'])));
        },
      );
    } else {
      return Container();
    }
  }
}
