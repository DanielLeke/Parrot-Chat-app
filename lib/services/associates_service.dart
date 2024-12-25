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
    if (contacts != null) {
      for (Contact contact in contacts) {
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          String? phoneNumber = contact.phones!.first.value;
          if (phoneNumber != null) {
            String formattedNumber =
                await _formatNumberService.formatPhoneNumber(
              number: phoneNumber,
            );

            QuerySnapshot querySnapshot = await _firestore
                .collection('users')
                .where('number', isEqualTo: formattedNumber)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              _firestore.collection('associates').doc().set({
                'uid': querySnapshot.docs.first.id,
                'email': querySnapshot.docs.first['email'],
                'name': querySnapshot.docs.first['name'],
                'number': formattedNumber,
              });
            }
          }
        }
      }
    }
  }
}
