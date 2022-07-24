import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/lawyer.dart';


class LawyerAPIServices extends ChangeNotifier{
  final url = "https://dalilvision.com/wp-json/wp/v2/job_listing";
  List<Lawyer> lawyersList = [];
  List<Lawyer> staticLawyersList = [];

  Future<List<Lawyer>> fetchLawyers() async{
    final response = await get(Uri.parse(url.toString()));
    if(response.statusCode == 200){
      var dynamicLawyersList = jsonDecode(response.body);
      lawyersList = List<Lawyer>.from(dynamicLawyersList.map((x) => Lawyer.fromJson(x)));
      // lawyersList.insert(0, Lawyer.fromJson(dynamicLawyersList.map((x) => Lawyer.fromJson(x))));
      staticLawyersList = List.from(lawyersList);
      notifyListeners();
      return lawyersList;
    }
    else{
      notifyListeners();
      throw Exception(response.statusCode);
    }
  }

  Future<List<Lawyer>> sortLawyersList({required Future<Position> devicePosition,
    required Future<List<Lawyer>> lawyersList}) async {
    Position position = await devicePosition;
    List<Lawyer> list = await lawyersList;
    for (var element in list) {
      if (element.data.location!.latitude == null ||
          element.data.location!.latitude == null) {
        continue;
      }
      else {
        double lat = double.parse('${element.data.location!.latitude}');
        double lon = double.parse('${element.data.location!.longitude}');
        double distanceInMeters = Geolocator.distanceBetween(
            position.latitude, position.longitude, lat, lon);
        double distanceInKilos = distanceInMeters/ 1000.0;
        element.distance = distanceInKilos;
      }
    }

    for(int outer = 0; outer < list.length; outer++){
      if(list[outer].data.location?.latitude == null){
        continue;
      }
      for(int inner = 1; inner < list.length; inner++){
        if(list[inner].data.location?.latitude == null){
          continue;
        }
        if(list[inner].distance! >= list[outer].distance!){
          Lawyer toUp = list[inner];
          Lawyer toDown = list[outer];
          list[outer] = toUp;
          list[inner] = toDown;
        }
      }
    }

    list.removeWhere((element) => element.distance == null);
    notifyListeners();
    return list;
  }

  void getFullListOfLawyers() {
    lawyersList.clear(); // to make sure that the list is clean from older operations
    lawyersList.addAll(staticLawyersList);// the trick
    notifyListeners();
  }

  void getLawyersByRangeDistance({required range})  {
    if(range == 0) {
      getFullListOfLawyers();
      return;
    }
    lawyersList.clear();
    staticLawyersList.forEach((element) {
      if(element.distance != null) {
        if (element.distance! <= range) {
          lawyersList.add(element);
        }
      }
    });
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await launch(googleUrl)) {

    } else {
      throw 'Could not open the map.';
    }
  }
}