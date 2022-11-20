import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:gns_crud_demo/models/fruit.dart';
import 'package:http/http.dart' as http;

class FruitsProvider with ChangeNotifier {
  final List<Fruit> _fruits = [];
  List<Fruit> get fruits => [..._fruits];

  Future<void> loadAllFruits() async {
    try {
      _fruits.clear();
      var url = Uri.parse(
          'https://gnscruddemo-default-rtdb.firebaseio.com/fruits.json');

      final response = await http.get(url);
      final Map<String, dynamic> extractedData =
          convert.json.decode(response.body);

      extractedData.forEach((fId, fData) {
        _fruits.add(
          Fruit(
            id: fId,
            name: fData['name'],
            color: fData['color'],
          ),
        );
      });
      notifyListeners();
    } catch (e) {
      print('ERROR! - ${e.toString()}');
    }
  }

  // Create
  Future<void> insertFruit(String name, String color) async {
    try {
      var url = Uri.parse(
          'https://gnscruddemo-default-rtdb.firebaseio.com/fruits.json');

      final response = await http.post(
        url,
        body: convert.jsonEncode(<String, String>{
          'name': name,
          'color': color,
        }),
      );

      print(response.toString()); // ex. show dialog to inform the user

      var responseBody = convert.json.decode(response.body);
      String id = responseBody['name'];

      _fruits.add(Fruit(id: id, name: name, color: color));

      notifyListeners();
    } catch (e) {
      print('ERROR! - ${e.toString()}');
    }
  }

  // Read
  Future<void> getFruit(String fId) async {
    try {
      var url = Uri.parse(
          'https://gnscruddemo-default-rtdb.firebaseio.com/fruits/$fId.json');
      final response = await http.get(url);
      final Map<String, dynamic> extractedData =
          convert.json.decode(response.body);
      extractedData.forEach((fId, fData) {
        _fruits.add(
          Fruit(
            id: fId,
            name: fData['name'],
            color: fData['color'],
          ),
        );
      });
      notifyListeners();
    } catch (e) {
      print('ERROR! - ${e.toString()}');
    }
  }

  // Update
  Future<void> updateFruit(String fId,
      {String? newName, String? newColor}) async {
    try {
      var url = Uri.parse(
          'https://gnscruddemo-default-rtdb.firebaseio.com/fruits/$fId.json');

      if (newName == null && newColor == null) {
        return;
      } else if (newName != null && newColor == null) {
        await http.patch(
          url,
          body: convert.jsonEncode(<String, String>{
            'name': newName,
          }),
        );
      } else if (newName == null && newColor != null) {
        await http.patch(
          url,
          body: convert.jsonEncode(<String, String>{
            'color': newColor,
          }),
        );
      } else {
        await http.patch(
          url,
          body: convert.jsonEncode(<String, String>{
            'name': newName!,
            'color': newColor!,
          }),
        );
      }

      Fruit f = _fruits.firstWhere((element) => element.id == fId);
      if (newName != null && newName.isNotEmpty) f.name = newName;
      if (newColor != null && newColor.isNotEmpty) f.color = newColor;

      notifyListeners();
    } catch (e) {
      print('ERROR! - ${e.toString()}');
    }
  }

  // Delete
  Future<void> deleteFruit(String fId) async {
    try {
      var url = Uri.parse(
          'https://gnscruddemo-default-rtdb.firebaseio.com/fruits/$fId.json');
      await http.delete(url);
      _fruits.removeWhere((element) => element.id == fId); // del from app
      notifyListeners();
    } catch (e) {
      print('ERROR! - ${e.toString()}');
    }
  }
}
