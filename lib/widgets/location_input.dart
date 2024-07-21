import 'dart:convert';

import 'package:favorite_places_app_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LoacationInput extends StatefulWidget {
  const LoacationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<StatefulWidget> createState() {
    return _LoacationInput();
  }
}

class _LoacationInput extends State<LoacationInput> {
  var API_GOOOL = "AIzaSyD3C8zN-s4KNp3Thop_aodwDiFTv43yS3s";
  PlaceLocation? pickLocation;

  var _isGettingLocation = false;

  String get locationImage {
    if (pickLocation == null) {
      return '';
    }
    final lat = pickLocation!.latitude;
    final lng = pickLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$lng&key=$API_GOOOL';
  }

  void _getCurrentLoacaiton() async {
    setState(() {
      _isGettingLocation = true;
    });
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus permissionGranted;
    Position locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

  
    locationData = await requestLocationPermission();
    // print(locationData);
    // requestLocationPermission().then((local) {
    //   print("this is location: $local");
    // });
    final lat = locationData.latitude;
    final lnt = locationData.longitude;

    // if (lat == null || lnt == null) {
    //   return;
    // }


    // final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lnt&key=$API_GOOOL');
    // final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lnt&key=AIzaSyD3C8zN-s4KNp3Thop_aodwDiFTv43yS3s');
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lnt&key=AIzaSyD3C8zN-s4KNp3Thop_aodwDiFTv43yS3s");

    final response = await http.get(url);

    final responseData = json.decode(response.body);

    final address = responseData['results'][0]['formatted_address'];
    print("this is adress $address");

    setState(() {
      pickLocation = PlaceLocation(
        latitude: lat,
        longitude: lnt,
        adress: address,
      );
      _isGettingLocation = false;
    });

    widget.onSelectLocation(pickLocation!);
  }

  // this is get location
  Future<Position> requestLocationPermission() async {
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
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (pickLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }


    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLoacaiton,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}