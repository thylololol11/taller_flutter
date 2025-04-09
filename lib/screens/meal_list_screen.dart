import 'package:flutter/material.dart';
import 'dart:math';
import '../models/meal.dart';
import '../services/api_service.dart';
import 'meal_detail_screen.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key});

  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Meal>> allMealsFuture;
  List<Meal> displayedMeals = [];
  List<Meal> allLoadedMeals = []; // Para mantener la lista completa
  List<Meal> recommendedMeals = [];

  @override
  void initState() {
    super.initState();
    allMealsFuture = apiService.fetchMeals().then((meals) {
      print("Comidas cargadas inicialmente: ${meals.length}");
      for (var meal in meals) {
        print("Categoría de la API: ${meal.strCategory}");
      }
      allLoadedMeals = meals; // Guarda la lista completa
      _showAllMeals(); 
      _generateRecommendedMeals(meals);
      return meals;
    });
  }

  void _generateRecommendedMeals(List<Meal> allMeals) {
    if (allMeals.isNotEmpty) {
      final random = Random();
      Set<int> randomIndex = {};
      while (randomIndex.length < min(4, allMeals.length)) {
        randomIndex.add(random.nextInt(allMeals.length));
      }
      recommendedMeals = randomIndex.map((index) => allMeals[index]).toList();
    } else {
      recommendedMeals = [];
    }
  }

  void _showAllMeals() {
    setState(() {
      displayedMeals = allLoadedMeals;
      print("Mostrando todos los platos");
      print("Longitud de displayedMeals: ${displayedMeals.length}");
    });
  }

  void _showRecommendedMeals() {
    setState(() {
      displayedMeals = List.from(recommendedMeals);
      print("Mostrando platos recomendados");
      print("Longitud de displayedMeals (recomendados): ${displayedMeals.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Longitud de displayedMeals en build: ${displayedMeals.length}");
    return Scaffold(
      appBar: AppBar(title: Text('Recetas')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _showAllMeals,
                        child: Text('Todos los Platos'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: _showRecommendedMeals,
                        child: Text('Recomendados'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    displayedMeals == allLoadedMeals
                        ? 'Todos los Platos'
                        : 'Recomendados',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0.0,
                    maxHeight: viewportConstraints.maxHeight - 100,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: displayedMeals.length, //cantidad de recetas
                    itemBuilder: (context, index) {
                      final meal = displayedMeals[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MealDetailScreen(meal: meal),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.network(
                                    meal.strMealThumb,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(child: Icon(Icons.broken_image));
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 8.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  meal.strMeal,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}