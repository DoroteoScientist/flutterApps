
import 'package:dio/dio.dart';
import 'package:flutter_application_1/Models/populkar_model.dart';
import 'package:flutter_application_1/Models/video_model.dart';
import 'package:flutter_application_1/Models/actor_model.dart';

class ApiPopular {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '5019e68de7bc112f4e4337a500b96c56';
  final String _language = 'es-MX';
  final dio = Dio();

  // Obtener películas populares
  Future<List<PopularModel>> getPopularMovies() async {
    final url = '$_baseUrl/movie/popular?api_key=$_apiKey&language=$_language&page=1';
    final response = await dio.get(url);
    final res = response.data['results'] as List;
    return res.map((movie) => PopularModel.fromMap(movie)).toList();
  }

  // Obtener videos/trailers de una película
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    final url = '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey&language=$_language';
    final response = await dio.get(url);
    final res = response.data['results'] as List;
    return res.map((video) => VideoModel.fromMap(video)).toList();
  }

  // Obtener actores de una película
  Future<List<ActorModel>> getMovieActors(int movieId) async {
    final url = '$_baseUrl/movie/$movieId/credits?api_key=$_apiKey';
    final response = await dio.get(url);
    final res = response.data['cast'] as List;
    return res.map((actor) => ActorModel.fromMap(actor)).toList();
  }

  // Agregar película a favoritos
  Future<bool> addToFavorites(int movieId) async {
    final url = '$_baseUrl/account/{account_id}/favorite?api_key=$_apiKey';
    try {
      final response = await dio.post(
        url,
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": true
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDE5ZTY4ZGU3YmMxMTJmNGU0MzM3YTUwMGI5NmM1NiIsInN1YiI6IjY3NGNmNTNlOWJiZjdmMDJhZjJmMzNjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.your_token_here'
          },
        ),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  // Eliminar película de favoritos
  Future<bool> removeFromFavorites(int movieId) async {
    final url = '$_baseUrl/account/{account_id}/favorite?api_key=$_apiKey';
    try {
      final response = await dio.post(
        url,
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": false
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDE5ZTY4ZGU3YmMxMTJmNGU0MzM3YTUwMGI5NmM1NiIsInN1YiI6IjY3NGNmNTNlOWJiZjdmMDJhZjJmMzNjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.your_token_here'
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }

  // Obtener películas favoritas
  Future<List<PopularModel>> getFavoriteMovies() async {
    final url = '$_baseUrl/account/{account_id}/favorite/movies?api_key=$_apiKey&language=$_language&page=1';
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDE5ZTY4ZGU3YmMxMTJmNGU0MzM3YTUwMGI5NmM1NiIsInN1YiI6IjY3NGNmNTNlOWJiZjdmMDJhZjJmMzNjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.your_token_here'
          },
        ),
      );
      final res = response.data['results'] as List;
      return res.map((movie) => PopularModel.fromMap(movie)).toList();
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }
}

//diferencia entre dio y http
//la primera maneja cache y la segunda no

//las peticiones se requieren hacer en segundo plano, por eso 
// es un metodo asincrono

//la instalacion de la base de datos no se instala en la aplicacion, se instala afuera
//solo se instala la logica de la base de datos
//el manejo de ve5rsiones
//las abses de datos se etiquetan con versiones
//metodo de creacion de base de datos
//metidi de actualizaciobn de base de datos
//tambien se puede hacer un downgrade