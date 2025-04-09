import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.strMeal)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal.strMealThumb),
            SizedBox(height: 16.0),
            Text('Categoría: ${meal.strCategory}', style: TextStyle(fontSize: 18.0)),
            Text('Área: ${meal.strArea}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('Instrucciones:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Text(meal.strInstructions),
          ],
        ),
      ),
    );
  }
}