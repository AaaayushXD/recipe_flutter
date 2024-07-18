import 'package:flutter_project/models/recipe.dart';
import 'package:flutter_project/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HttpService _httpService = HttpService();
  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipe(String filter) async {
    String path = "recipes/";
    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }
    var response = await _httpService.get(path);

    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];

      try {
        var recipes = data.map((e) => Recipe.fromJson(e)).toList();
        return recipes;
      } catch (e, stacktrace) {
        print("Error occurred: $e");
        print("Stacktrace: $stacktrace");
      }
    }
    return null;
  }
}
