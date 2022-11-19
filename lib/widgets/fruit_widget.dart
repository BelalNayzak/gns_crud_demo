import 'package:flutter/material.dart';
import 'package:gns_crud_demo/providers/fruits_provider.dart';
import 'package:gns_crud_demo/screens/add_screen.dart';
import 'package:provider/provider.dart';

import '../models/fruit.dart';

class FruitWidget extends StatelessWidget {
  final Fruit item;
  const FruitWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final FruitsProvider fpv = Provider.of<FruitsProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("id:${item.id}"),
        Text("name: ${item.name}"),
        Text("color:${item.color}"),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddScreen.id, arguments: {
                  'id': item.id,
                  'name': item.name,
                  'color': item.color,
                });
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                fpv.deleteFruit(item.id);
              },
              icon: Icon(Icons.delete_forever),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
