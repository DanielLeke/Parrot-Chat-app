import 'package:flutter/material.dart';
import 'package:parrot/pages/homepage.dart';
import 'package:parrot/pages/signup.dart';
import 'package:parrot/services/auth_service.dart';

TextEditingController signinNameController = TextEditingController();
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
            padding: EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 24),
            child: Name(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
            child: EmailField(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
            child: PasswordField(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36, left: 24, right: 24, bottom: 24),
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

class Name extends StatelessWidget {
  const Name({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              fontFamily: 'DM Sans'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: nameController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'John Doe',
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
        onPressed: () async {
          AuthService authService = AuthService();

          String result = await authService.signin(
              email: _emailController.text,
              password: _passwordController.text,
              name: signinNameController.text);

          if (signinNameController.text != nameController.text) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "The username provided is incorrect",
              style: const TextStyle(
                  fontFamily: 'DM Sans', color: Colors.white, fontSize: 14),
            ),
            backgroundColor: Colors.grey[850],
            duration: const Duration(seconds: 3),
          ));
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              result,
              style: const TextStyle(
                  fontFamily: 'DM Sans', color: Colors.white, fontSize: 14),
            ),
            backgroundColor: Colors.grey[850],
            duration: const Duration(seconds: 3),
          ));

          if (result == 'No user found for that email.' ||
              result == 'You entered in an invalid email/password' || signinNameController.text != nameController.text) {
          } else {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
                (Route<dynamic> route) => false,
              );
            });
          }
        },
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
