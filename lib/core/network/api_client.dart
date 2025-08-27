import 'package:dio/dio.dart';
import 'dio_provider.dart';

class ApiClient {
  final Dio _dio = DioProvider.createDio();

  Future<List<dynamic>> getPopularMovies() async {
    final response = await _dio.get('/movie/popular');
    return response.data['results'];
  }

  Future<List<dynamic>> getTopRatedMovies() async {
    final response = await _dio.get('/movie/top_rated');
    return response.data['results'];
  }

  Future<List<dynamic>> getTrendingTvShows() async {
    final response = await _dio.get('/tv/popular');
    return response.data['results'];
  }
}