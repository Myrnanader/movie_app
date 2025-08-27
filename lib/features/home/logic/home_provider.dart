import 'package:flutter/material.dart';
import '../../../core/network/dio_provider.dart';
import '../models/movie_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Movie> trending = [];
  List<Movie> nowPlaying = [];
  List<Movie> topRated = [];
  List<Movie> upcoming = [];

  bool isLoading = false;

  Future<void> fetchAllSections() async {
    isLoading = true;
    notifyListeners();

    try {
      final dio = DioProvider.createDio();

      final trendingRes = await dio.get('/trending/movie/day');
      final nowPlayingRes = await dio.get('/movie/now_playing');
      final topRatedRes = await dio.get('/movie/top_rated');
      final upcomingRes = await dio.get('/movie/upcoming');

      trending = _mapToMovies(trendingRes.data['results']);
      nowPlaying = _mapToMovies(nowPlayingRes.data['results']);
      topRated = _mapToMovies(topRatedRes.data['results']);
      upcoming = _mapToMovies(upcomingRes.data['results']);
    } catch (e) {
      print('Error fetching movies: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  List<Movie> _mapToMovies(List<dynamic> jsonList) {
    return jsonList.map((json) => Movie.fromJson(json)).toList();
  }
}