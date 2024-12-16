import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parrot/pages/signin.dart';
import 'package:parrot/services/auth_service.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: const NavBarItem(),
            backgroundColor: Colors.white,
            body: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Header(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 24),
                  child: EmailField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
                  child: PasswordField(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
                  child: ConfirmPasswordField(),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: SignupBtn(),
                ),
              ],
            )));
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
        Text(
          "Let's create an account for you!",
          style: TextStyle(
              fontFamily: "DM Sans", fontWeight: FontWeight.bold, fontSize: 22),
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

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Confirm Password",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              fontFamily: 'DM Sans'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _confirmPasswordController,
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

class SignupBtn extends StatelessWidget {
  const SignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: const Size(220, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: () async {
          AuthService authService = AuthService();

          String result = await authService.signup(
              email: _emailController.text, password: _passwordController.text);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              result,
              style: const TextStyle(
                  fontFamily: 'DM Sans', color: Colors.white, fontSize: 14),
            ),
            backgroundColor: Colors.grey[850],
            duration: const Duration(seconds: 3),
          ));

          if (result == 'An account already exists with that email' ||
              result == 'The password provided is too weak') {
          } else {}
        },
        child: const Text(
          "Sign Up",
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
          "Already a member?",
          style: TextStyle(fontSize: 16, fontFamily: 'DM Sans'),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signin()));
            },
            child: const Text(
              "Log in",
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
