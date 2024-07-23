import 'package:favorite_places_app_flutter/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(latitude: 37.422, longitude: -122.0, adress: ''),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _pickLocation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_pickLocation);
              },
            )
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting ? null : (position) {
          setState(() {
            _pickLocation = position;
          },);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16, 
        ),
        markers: (_pickLocation == null && widget.isSelecting == true)  ? {} : {
          Marker(
            markerId: const MarkerId('m1'),
            // this means if is null we use left iteration after question mark else right iteration
            position: _pickLocation ?? LatLng(
                widget.location.latitude,
                widget.location.longitude,
            ),
          ),
        },
      ),
    );
  }
}
