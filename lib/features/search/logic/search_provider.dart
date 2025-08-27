import 'package:flutter/material.dart';

import '../../../core/network/dio_provider.dart';
import '../../home/models/movie_model.dart';

class SearchProvider extends ChangeNotifier {
  List<Movie> results = [];
  bool isLoading = false;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      results = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final dio = DioProvider.createDio();
      final response = await dio.get('/search/movie', queryParameters: {
        'query': query,
      });

      results = (response.data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } catch (e) {
      print('Search error: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}