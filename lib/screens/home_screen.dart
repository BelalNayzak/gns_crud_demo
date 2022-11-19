import 'package:flutter/material.dart';
import 'package:gns_crud_demo/providers/fruits_provider.dart';
import 'package:gns_crud_demo/screens/add_screen.dart';
import 'package:gns_crud_demo/widgets/fruit_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FruitsProvider fpv = Provider.of<FruitsProvider>(context);

    if (fpv.fruits.isEmpty) {
      fpv.loadAllFruits();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('GNS CRUD DEMO'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddScreen.id);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(children: [
        if (fpv.fruits.isEmpty)
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ListView.builder(
          itemCount: fpv.fruits.length,
          itemBuilder: (context, index) {
            return FruitWidget(item: fpv.fruits[index]);
          },
        ),
      ]),
    );
  }
}
