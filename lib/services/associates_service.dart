import 'package:cloud_firestore/cloud_firestore.dart';

class AssociatesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Iterable<Contact>?> getContacts() async {
    Iterable<Contact>? contacts;
    if (await Permission.contacts.request().isGranted) {
      contacts = await ContactsService.getContacts();
    } else {
      // Handle permission denied
    }
    return contacts;
  }
}