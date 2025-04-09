class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strInstructions;
  final String strCategory;
  final String strArea;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strInstructions,
    required this.strCategory,
    required this.strArea,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
    );
  }
}

class MealList {
  final List<Meal> meals;

  MealList({
    required this.meals,
  });

  factory MealList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> mealsJson = json['meals'];
    final List<Meal> meals = mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
    return MealList(meals: meals);
  }
}