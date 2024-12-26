import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:parrot/services/format_number_service.dart';

class ServiceOfContacts {
  Future<Iterable<Contact>?> getContacts() async {
    Iterable<Contact>? contacts;
    if (await Permission.contacts.request().isGranted) {
      contacts = await ContactsService.getContacts();
    } else {
      // Handle permission denied
    }
    return contacts;
  }

  Future<List<String>> contactPhoneNumbers() async {
    List<String> contactsPhoneNumbers = [];
    Iterable<Contact>? contacts = await getContacts();
    if (contacts != null) {
      for (var contact in contacts) {
        for (var phone in contact.phones!) {
          contactsPhoneNumbers.add(phone.value!);
        }
      }
    }
    return contactsPhoneNumbers;
  }

  Future<Set<String>> formattedContactNumbers() async {
    FormatNumberService _formatNumberService = FormatNumberService();
    List<String> phoneNumbersOfContacts = await contactPhoneNumbers();

    Set<String> formattedNumbers = Set<String>.from((await Future.wait(
      phoneNumbersOfContacts.map((number) => _formatNumberService.formatPhoneNumber(number: number)
          .then((formatted) => formatted.trim())
          .catchError((e) => '')), // Skip invalid numbers
    ))
        .where((number) => number.isNotEmpty));

    return formattedNumbers;
  }
}
