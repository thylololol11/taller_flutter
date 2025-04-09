import 'package:flutter/material.dart';
import 'screens/meal_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => MealListScreen(),
        '/about': (context) => screebabout(),
      },
    );
  }

  dynamic screebabout() => screebabout();
}
