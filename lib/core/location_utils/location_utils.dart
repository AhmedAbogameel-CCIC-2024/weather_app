import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationUtils {
  static LatLng currentLocation = LatLng(31.0409, 31.3785);

  static Future<LatLng?> getDeviceLocation() async {
    final status = await Geolocator.requestPermission();
    if (status != LocationPermission.always &&
        status != LocationPermission.whileInUse) {
      /// TODO: Show Alert Dialog
      print("Location Permission Denied");
      return null;
    }
    final position = await Geolocator.getCurrentPosition();
    currentLocation = LatLng(position.latitude, position.longitude);
    return currentLocation;
  }
}
