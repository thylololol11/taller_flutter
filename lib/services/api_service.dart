import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class ApiService {  
  final String baseUrl = 'www.themealdb.com/api/json/v1/1';

  Future<List<Meal>> fetchMeals() async {
    final response = await http.get(Uri.parse('https://$baseUrl/search.php?s='));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealList = MealList.fromJson(data);
      return mealList.meals;
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<Meal> fetchMealDetails(String idMeal) async {
    final response = await http.get(Uri.parse('https://$baseUrl/lookup.php?i=$idMeal'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealList = MealList.fromJson(data);
      return mealList.meals.first;
    } else {
      throw Exception('Failed to load meal details');
    }
  }
} 