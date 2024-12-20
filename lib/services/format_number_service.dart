import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:libphonenumber/libphonenumber.dart';

class FormatNumberService {
  Future<String> getIsoCode() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled != true) {
      return 'NG';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'NG';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'NG';
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first.isoCountryCode ?? 'NG';
  }

  Future<String> formatPhoneNumber(String number) async {
    String isoCode = await getIsoCode();
    bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
      phoneNumber: number,
      isoCode: isoCode,
    );
    if (isValid == true) {
      return await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: number,
        isoCode: isoCode,
      ) as String;
    } else {
      return 'Invalid phone number';
    }
  }
}