import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/populkar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<PopularModel> favoriteMovies = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarFavs();
  }

  Future<void> _cargarFavs() async {
    final preferencias = await SharedPreferences.getInstance();
    // Asegúrate de que esta clave coincida con la que usas en DetailPopularMovieScreen
    final datosPeliJson = preferencias.getStringList('peliFav') ?? [];
    
    List<PopularModel> movies = [];
    for (String movieJson in datosPeliJson) {
      try {
        final movieData = json.decode(movieJson);
        movies.add(PopularModel(
          id: movieData['id'],
          title: movieData['title'],
          posterPath: movieData['posterPath'],
          backdropPath: movieData['backdropPath'],
          overview: movieData['overview'],
          voteAverage: movieData['voteAverage'] is int 
              ? movieData['voteAverage'].toDouble()
              : movieData['voteAverage'],
          releaseDate: movieData['releaseDate'],
          originalLanguage: movieData['originalLanguage'] ?? '',
          originalTitle: movieData['originalTitle'] ?? movieData['title'],
          popularity: movieData['popularity']?.toDouble() ?? 0.0,
          voteCount: movieData['voteCount'] ?? 0,
        ));
      } catch (e) {
        print('Error parsing favorite movie: $e');
      }
    }
    
    setState(() {
      favoriteMovies = movies;
      cargando = false;
    });
  }

  Future<void> _removeFavorite(PopularModel movie) async {
    final preferencias = await SharedPreferences.getInstance();
    List<String> favorites = preferencias.getStringList('favorites') ?? [];
    List<String> datosPeliJson = preferencias.getStringList('peliFav') ?? [];

    favorites.remove(movie.id.toString());
    datosPeliJson.removeWhere((movieJson) {
      final movieData = json.decode(movieJson);
      return movieData['id'] == movie.id;
    });

    await preferencias.setStringList('favorites', favorites);
    await preferencias.setStringList('peliFav', datosPeliJson);

    setState(() {
      favoriteMovies.removeWhere((m) => m.id == movie.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${movie.title} eliminada de favoritos'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Favoritos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : favoriteMovies.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No tienes películas favoritas',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Agrega películas a tus favoritos desde la pantalla de detalles',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _cargarFavs,
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: favoriteMovies.length,
                    itemBuilder: (context, index) {
                      final movie = favoriteMovies[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detailPopular',
                              arguments: movie,
                            ).then((_) => _cargarFavs());
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Poster
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    movie.posterPath,
                                    width: 80,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 120,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.movie, size: 40),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            movie.voteAverage.toStringAsFixed(1),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(width: 16),
                                          Text(
                                            movie.releaseYear,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        movie.overview,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite, color: Colors.red),
                                  onPressed: () => _removeFavorite(movie),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}