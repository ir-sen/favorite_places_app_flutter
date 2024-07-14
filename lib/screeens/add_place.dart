

import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {

  const AddPlaceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddPlaceScreen> {

  final _titleControler = TextEditingController();

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
            const SizedBox(height: 16,),
            ElevatedButton.icon( 
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              )

          ],
      ),),
    );
  }
}