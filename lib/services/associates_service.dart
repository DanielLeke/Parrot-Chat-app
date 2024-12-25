import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:parrot/services/format_number_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AssociatesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FormatNumberService _formatNumberService = FormatNumberService();

  Future<Iterable<Contact>?> getContacts() async {
    Iterable<Contact>? contacts;
    if (await Permission.contacts.request().isGranted) {
      contacts = await ContactsService.getContacts();
    } else {
      // Handle permission denied
    }
    return contacts;
  }

  Future<void> findAssociates() async {
  Iterable<Contact>? contacts = await getContacts();
  if (contacts == null) return;

  // Batch all number formatting
  List<String> formattedNumbers = await Future.wait(
    contacts.where((c) => c.phones?.isNotEmpty ?? false).map((contact) async {
      return await _formatNumberService.formatPhoneNumber(
        number: contact.phones!.first.value!,
      );
    })
  );

  // Batch Firestore query
  QuerySnapshot querySnapshot = await _firestore
      .collection('users')
      .where('number', whereIn: formattedNumbers)
      .get();

  // Batch write operations
  WriteBatch batch = _firestore.batch();
  for (var doc in querySnapshot.docs) {
    batch.set(_firestore.collection('associates').doc(), {
      'uid': doc.id,
      'email': doc['email'],
      'name': doc['name'],
      'number': doc['number'],
    });
  }
  await batch.commit();
}
}
