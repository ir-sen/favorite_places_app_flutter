
import 'dart:io';
import 'package:favorite_places_app_flutter/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app_flutter/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {

  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenSteate();
  }

}

class _AddPlaceScreenSteate extends ConsumerState<AddPlaceScreen> {

  final _titleControler = TextEditingController();
  File? _selectedImage; // get selected image

  void _savePlace() {
    final enteredTitle = _titleControler.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    // put into ref
    ref.read(userPlacesProveder.notifier).addPlace(enteredTitle, _selectedImage!);

    Navigator.of(context).pop();

  }

  @override
  void dispose() {
    _titleControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title',),
            controller: _titleControler,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground,),
            ),
            // Image Input
            const SizedBox(height: 10,),
            // show what selected file we picked 
            ImageInput(onPickImage: (image) {
              _selectedImage = image;
            },),

            const SizedBox(height: 16,),
            ElevatedButton.icon( 
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              )

          ],
      ),),
    );
  }
}