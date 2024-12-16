import 'package:flutter/material.dart';
import 'package:parrot/pages/signup.dart';
import 'package:parrot/services/auth_service.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
              onPressed: () async{
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
}
