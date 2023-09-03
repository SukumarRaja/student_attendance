import 'package:location/location.dart';
import '../utility/utility.dart';

class LocationService {
  Location location = Location();
  late LocationData _locationData;

  Future<Map<String, double?>> initializeAndGetLocation(context) async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    ///First check whether location in enabled or not in device
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      Utility.showSnackBar(
          message: "Please Enable Location Service", context: context);
    }

    /// If service enabled then ask to permission for location from user
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        Utility.showSnackBar(
            message: "Please allow location access", context: context);
      }
    }

    ///After permission is granted then returned  the coordinates
    _locationData = await location.getLocation();
    return {
      'latitude': _locationData.latitude!,
      'longitude': _locationData.longitude!
    };
  }
}
