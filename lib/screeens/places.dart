import 'package:favorite_places_app_flutter/providers/user_places.dart';
import 'package:favorite_places_app_flutter/screeens/add_place.dart';
import 'package:favorite_places_app_flutter/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userPlaces = ref.watch(userPlacesProveder);
    
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          )
        ],
      ),


      body: PlacesList(
        places: userPlaces,
      ),
    );
  }
}
