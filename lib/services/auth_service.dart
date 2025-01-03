import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parrot/pages/signup.dart';
import 'package:parrot/services/contacts_service.dart';
import 'package:parrot/services/format_number_service.dart';

class AuthService {
  Future<String> getPhoneNumber() async {
    FormatNumberService _formatNumberService = FormatNumberService();
      String formattedPhoneNumber = await _formatNumberService.formatPhoneNumber(
          number: numberController.text);
      return formattedPhoneNumber;
  }

  Future<String> signup(
      {required String email,
      required String password,
      required String name}) async {
    String message = '';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      message = 'Success';
      ServiceOfContacts _serviceOfContacts = ServiceOfContacts();
      List<String> conctactsNumbers = await _serviceOfContacts.formattedContactNumbers();
      String phoneNumber = await getPhoneNumber();
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'email': email,
        'name': name,
        'number': phoneNumber,
        'contact-numbers': conctactsNumbers
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      } else {
        message = 'An error occurred: ${e.message}';
      }
    } catch (e) {
      message = "An unexpected error has occurred: ${e}";
    }
    print(message);
    return message;
  }

  Future<String> signin(
      {required String email,
      required String password,
      required String name}) async {
    String message = '';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      message = 'Success';
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'email': email,
        'name': name
      }, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        message = 'You entered in an invalid email/password';
      } else {
        message = 'An error occurred: ${e.message}';
      }
    } catch (e) {
      message = 'An unexpected error occurred';
    }
    print(message);
    return message;
  }

  Future<void> signout() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
    } else {
      FirebaseAuth.instance.signOut();
    }
  }
}
