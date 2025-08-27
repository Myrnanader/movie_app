import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_provider.dart';
import '../models/movie_details_model.dart';
import '../models/cast_model.dart';
import '../models/video_model.dart';

class DetailsProvider extends ChangeNotifier {
  MovieDetails? movie;
  List<CastMember> cast = [];
  List<VideoModel> trailers = [];

  bool isLoadingDetails = false;
  bool isLoadingCast = false;
  bool isLoadingVideos = false;

  final Dio _dio = DioProvider.createDio();

  Future<void> fetchMovieDetails(int movieId) async {
    isLoadingDetails = true;
    notifyListeners();

    try {
      final response = await _dio.get('/movie/$movieId');
      movie = MovieDetails.fromJson(response.data);
    } catch (e) {
      print('Error fetching movie details: $e');
    }

    isLoadingDetails = false;
    notifyListeners();
  }

  Future<void> fetchMovieCast(int movieId) async {
    isLoadingCast = true;
    notifyListeners();

    try {
      final response = await _dio.get('/movie/$movieId/credits');
      final List<dynamic> castJson = response.data['cast'];
      cast = castJson.map((json) => CastMember.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching cast: $e');
    }

    isLoadingCast = false;
    notifyListeners();
  }

  Future<void> fetchMovieVideos(int movieId) async {
    isLoadingVideos = true;
    notifyListeners();

    try {
      final response = await _dio.get('/movie/$movieId/videos');
      final List<dynamic> videosJson = response.data['results'];
      trailers = videosJson
          .map((json) => VideoModel.fromJson(json))
          .where((video) => video.site == 'YouTube' && video.type == 'Trailer')
          .toList();
    } catch (e) {
      print('Error fetching videos: $e');
    }

    isLoadingVideos = false;
    notifyListeners();
  }

  Future<void> fetchAllMovieData(int movieId) async {
    await Future.wait([
      fetchMovieDetails(movieId),
      fetchMovieCast(movieId),
      fetchMovieVideos(movieId),
    ]);
  }
}