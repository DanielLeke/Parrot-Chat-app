import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late final String senderId;
  late final String senderEmail;
  late final String receiverId;
  late final String message;
  late final Timestamp timestamp;

  Message(
      {
      required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}
