import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:gns_crud_demo/models/fruit.dart';
import 'package:http/http.dart' as http;

class FruitsProvider with ChangeNotifier {
  final List<Fruit> _fruits = [];
  List<Fruit> get fruits => [..._fruits];

  Future<void> loadAllFruits() async {
    try {
      var url = Uri.parse('http://localhost/api_demo_gns/php/load_all_f.php');
      final response = await http.post(url);
      final Map<String, dynamic> extractedData =
          convert.json.decode(response.body);
      extractedData.forEach((fId, fData) {
        _fruits.add(
          Fruit(
            id: fId,
            name: fData['admin'],
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
      var url = Uri.parse('http://localhost/api_demo_gns/php/insert_f.php');

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
      var url = Uri.parse('http://localhost/api_demo_gns/php/get_f.php');
      final response = await http.post(url, body: {'id': fId});
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
      var url = Uri.parse('http://localhost/api_demo_gns/php/update_f.php');

      if (newName == null && newColor == null) {
        return;
      }

      final response = await http.put(
        url,
        body: convert.jsonEncode(<String, String>{
          'id': fId,
          'name': newName ?? '',
          'color': newColor ?? '',
        }),
      );

      print(response.toString()); // ex. show dialog to inform the user

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
      var url = Uri.parse('http://localhost/api_demo_gns/php/delete_f.php');
      await http.post(url, body: {'id': fId});
      _fruits.removeWhere((element) => element.id == fId); // del from app
      notifyListeners();
    } catch (e) {
      print('ERROR! - ${e.toString()}');
    }
  }
}
