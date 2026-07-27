import 'dart:convert';
import 'package:api_practice_app/recipe.dart';
import 'package:http/http.dart' as http;
class RecipeService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  Future<List<Recipe>> searchRecipes(String query) async {
    final url = Uri.parse('$_baseUrl/search.php?s=$query');
    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );
      if (response.statusCode != 200) {
        throw Exception('Server error (${response.statusCode}). Please try again.');
      }
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if (meals == null) {
        return []; // no results found — not an error, just empty
      }
      return (meals as List)
          .map((meal) => Recipe.fromSearchJson(meal))
          .toList();
    } on http.ClientException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Something went wrong. Please try again.');
    }
  }
  Future<List<Recipe>> getRandomRecipes({int count = 8}) async {
    final recipes = <Recipe>[];
    try {
      for (int i = 0; i < count; i++) {
        final url = Uri.parse('$_baseUrl/random.php');
        final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final meals = data['meals'];
          if (meals != null && meals.isNotEmpty) {
            recipes.add(Recipe.fromSearchJson(meals[0]));
          }
        }
      }
      return recipes;
    } on http.ClientException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}