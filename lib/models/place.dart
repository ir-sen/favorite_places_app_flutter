import 'dart:io';
import 'package:uuid/uuid.dart'; // this for generate id


const uuid = Uuid();


class PlaceLocation {

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.adress,
  });

  final double latitude;
  final double longitude;
  final String adress;
}

// just create pojo objest for 
class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}