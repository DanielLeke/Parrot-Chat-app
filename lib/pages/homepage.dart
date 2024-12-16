import 'package:flutter/material.dart';

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
