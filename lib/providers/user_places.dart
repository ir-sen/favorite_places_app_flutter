import 'package:favorite_places_app_flutter/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void  addPlace(String title, File image, PlaceLocation location) {
    final newPlace = Place(title: title, image: image, location: location);
    // updat  state add new state
    state = [newPlace, ...state];

  }

  
} 
// this function for get this provider state rerun list 
final userPlacesProveder = StateNotifierProvider<UserPlacesNotifier, List<Place>>(
    (ref) => UserPlacesNotifier(),
  );