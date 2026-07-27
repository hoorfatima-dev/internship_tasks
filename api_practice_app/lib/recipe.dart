
class Recipe {
  final String id;
  final String name;
  final String thumbnail;
  final String? category;
  final String? area;
  final String? instructions;
  final List<String> ingredients;
  final List<String> measures;
  Recipe({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category,
    this.area,
    this.instructions,
    this.ingredients = const [],
    this.measures = const [],
  });
  factory Recipe.fromSearchJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString().trim());
        measures.add((measure ?? '').toString().trim());
      }
    }
    return Recipe(
      id: json['idMeal']?.toString() ?? '',
      name: json['strMeal'] ?? 'Unknown recipe',
      thumbnail: json['strMealThumb'] ?? '',
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}