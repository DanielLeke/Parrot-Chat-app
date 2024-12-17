import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late final String senderName;
  late final String senderId;
  late final String senderEmail;
  late final String receiverName;
  late final String receiverId;
  late final String receiverEmail;
  late final String message;
  late final Timestamp timestamp;

  Message(
      {required this.senderName,
      required this.senderId,
      required this.senderEmail,
      required this.receiverName,
      required this.receiverId,
      required this.receiverEmail,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverName': receiverName,
      'receiverId': receiverId,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': timestamp
    };
  }
}
