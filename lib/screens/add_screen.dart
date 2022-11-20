import 'package:flutter/material.dart';
import 'package:gns_crud_demo/providers/fruits_provider.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  static const id = 'AddScreen';

  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final FruitsProvider fpv = Provider.of<FruitsProvider>(context);

    TextEditingController ctrlName = TextEditingController();
    TextEditingController ctrlColor = TextEditingController();

    if (args != null) {
      args as Map<String, String>;
      if (args['name'] != null) {
        ctrlName.text = (args['name'])!;
      }
      if ((args)['color'] != null) {
        ctrlColor.text = (args['color'])!;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit'),
        actions: [
          IconButton(
            onPressed: () {
              String name = ctrlName.value.text;
              String color = ctrlColor.value.text;
              if (name.isNotEmpty && color.isNotEmpty) {
                if (args != null) {
                  args as Map<String, String>;
                  fpv.updateFruit(args['id']!,
                      newName: ctrlName.value.text,
                      newColor: ctrlColor.value.text);
                } else {
                  fpv.insertFruit(name, color);
                }
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
