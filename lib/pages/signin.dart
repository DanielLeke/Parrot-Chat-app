import 'package:flutter/material.dart';
import 'package:parrot/pages/signup.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavBarItem(),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 36.0),
            child: Header(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 24),
            child: EmailField(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 24),
            child: PasswordField(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 42, left: 24, right: 24, bottom: 24),
            child: SigninBtn(),
          ),
        ],
      ),
    ));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.message,
          size: 150,
          color: Colors.blue,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Welcome back, we've missed you!",
          style: TextStyle(
              fontFamily: "DM Sans", fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              fontFamily: 'DM Sans'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _emailController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'example@gmail.com',
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
      ],
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              fontFamily: 'DM Sans'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _passwordController,
          cursorColor: Colors.black,
          obscureText: true,
          decoration: InputDecoration(
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
      ],
    );
  }
}

class SigninBtn extends StatelessWidget {
  const SigninBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: const Size(220, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: () {},
        child: const Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.bold),
        ));
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "New here?",
          style: TextStyle(fontSize: 16, fontFamily: 'DM Sans'),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signup()));
            },
            child: const Text(
              "Create an account",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'DM Sans'),
            ))
      ],
    );
  }
}
