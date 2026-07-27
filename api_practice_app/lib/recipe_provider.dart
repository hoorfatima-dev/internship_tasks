import 'package:api_practice_app/recipe.dart';
import 'package:api_practice_app/recipe_service.dart';
import 'package:flutter/material.dart';
enum RecipeStatus { initial, loading, loaded, error }
class RecipeProvider extends ChangeNotifier {
  final RecipeService _service = RecipeService();
  List<Recipe> _recipes = [];
  RecipeStatus _status = RecipeStatus.initial;
  String _errorMessage = '';
  List<Recipe> get recipes => _recipes;
  RecipeStatus get status => _status;
  String get errorMessage => _errorMessage;
  Future<void> loadInitialRecipes() async {
    _status = RecipeStatus.loading;
    notifyListeners();
    try {
      _recipes = await _service.getRandomRecipes(count: 8);
      _status = RecipeStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _status = RecipeStatus.error;
    }
    notifyListeners();
  }
  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      await loadInitialRecipes();
      return;
    }
    _status = RecipeStatus.loading;
    notifyListeners();
    try {
      _recipes = await _service.searchRecipes(query.trim());
      _status = RecipeStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _status = RecipeStatus.error;
    }
    notifyListeners();
  }
  Future<void> retry(String lastQuery) async {
    if (lastQuery.trim().isEmpty) {
      await loadInitialRecipes();
    } else {
      await searchRecipes(lastQuery);
    }
  }
}