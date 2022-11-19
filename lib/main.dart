import 'package:flutter/material.dart';
import 'package:gns_crud_demo/providers/fruits_provider.dart';
import 'package:gns_crud_demo/screens/add_screen.dart';
import 'package:gns_crud_demo/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FruitsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (_) => HomeScreen(),
          AddScreen.id: (_) => AddScreen(),
        },
      ),
    ),
  );
}
