import 'package:flutter/material.dart';
import 'package:gns_crud_demo/providers/fruits_provider.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  static const id = 'AddScreen';

  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final FruitsProvider fpv = Provider.of<FruitsProvider>(context);

    TextEditingController ctrlName = TextEditingController();
    TextEditingController ctrlColor = TextEditingController();

    ctrlName.value = (args['name'] ?? '') as TextEditingValue;
    ctrlColor.value = (args['color'] ?? '') as TextEditingValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(args['name'] == null ? 'Add Fruit' : 'Edit Fruit'),
        actions: [
          IconButton(
            onPressed: () {
              String name = ctrlName.value.text;
              String color = ctrlColor.value.text;
              if (name.isNotEmpty && color.isNotEmpty) {
                args['name'] == null
                    ? fpv.insertFruit(name, color)
                    : fpv.updateFruit(args['id']!,
                        newName: args['name'], newColor: args['color']);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: ctrlName,
            decoration: const InputDecoration(
              hintText: 'name',
            ),
          ),
          TextField(
            controller: ctrlColor,
            decoration: const InputDecoration(
              hintText: 'color',
            ),
          ),
        ],
      ),
    );
  }
}
