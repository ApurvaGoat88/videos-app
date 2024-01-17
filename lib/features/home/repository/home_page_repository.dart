import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
class HomePageRepository{
  String _locationMessage = '';
    Future<String> locationforAppbar()async{
      final check  = await Geolocator.checkPermission() ;
      if ((check == LocationPermission.denied) || check ==LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
        return "" ;
      }
      else{
        return await getCurrentLocation() ;
      }
    }
  Future<String> getCurrentLocation()async{
      final check  = await Geolocator.checkPermission() ;
      if ((check == LocationPermission.denied) || check ==LocationPermission.deniedForever){
        await Geolocator.requestPermission() ;
        _locationMessage = 'Location permission denied';
      }
      else {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          if (placemarks.isNotEmpty) {
            Placemark place = placemarks[0];
            _locationMessage = place.locality.toString();
          } else {
            _locationMessage = 'City not found';
          }
        } catch (error) {
          print(error.toString());
        }
      }




    return _locationMessage ;



  }

  String get location => _locationMessage ;
}

final homeRepositoryProvider = Provider<HomePageRepository>((ref) => HomePageRepository()) ;