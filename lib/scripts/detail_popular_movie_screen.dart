import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/populkar_model.dart';
import 'package:flutter_application_1/Models/video_model.dart';
import 'package:flutter_application_1/Models/actor_model.dart';
import 'package:flutter_application_1/scripts/video_player_screen.dart';
import 'package:flutter_application_1/network/api_movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';

class DetailPopularMovieScreen extends StatefulWidget {
  const DetailPopularMovieScreen({super.key});

  @override
  State<DetailPopularMovieScreen> createState() => _DetailPopularMovieScreenState();
}

class _DetailPopularMovieScreenState extends State<DetailPopularMovieScreen> {
  final ApiPopular apiPopular = ApiPopular();
  List<VideoModel> videos = [];
  List<ActorModel> actors = [];
  bool cargando = true;
  bool favorito = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
      _cargarDatosPelicula(popular.id);
      _checarFav(popular.id);
    });
  }

  Future<void> _cargarDatosPelicula(int movieId) async {
    try {
      final videoTrailer = await apiPopular.getMovieVideos(movieId);
      final detallesActor = await apiPopular.getMovieActors(movieId);
      
      setState(() {
        videos = videoTrailer.where((video) => 
          video.type == 'Trailer' && video.site == 'YouTube').toList();
        actors = detallesActor.take(10).toList();
        cargando = false;
      });
    } catch (e) {
      setState(() {
        cargando = false;
      });
      print('Error cargando pelicula: $e');
    }
  }

  Future<void> _checarFav(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      favorito = favorites.contains(movieId.toString());
    });
  }

  Future<void> _fijarFav(PopularModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    List<String> peliFav = prefs.getStringList('peliFav') ?? [];

    if (favorito) {
      favorites.remove(movie.id.toString());
      peliFav.removeWhere((movieJson) {
        final movieData = json.decode(movieJson);
        return movieData['id'] == movie.id;
      });
    } else {
      favorites.add(movie.id.toString());
      peliFav.add(json.encode({
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'backdropPath': movie.backdropPath,
        'overview': movie.overview,
        'voteAverage': movie.voteAverage,
        'releaseDate': movie.releaseDate,
      }));
    }

    await prefs.setStringList('favorites', favorites);
    await prefs.setStringList('peliFav', peliFav);
    
    setState(() {
      favorito = !favorito;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(favorito 
          ? 'Agregado a favoritos' 
          : 'Eliminado de favoritos'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _playVideoInternally(String videoKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoId: videoKey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'backdrop-${popular.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(popular.backdropPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Hero(
                      tag: 'poster-${popular.id}',
                      child: Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            popular.posterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 160,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          popular.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          popular.releaseYear,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  favorito ? Icons.favorite : Icons.favorite_border,
                  color: favorito ? Colors.red : Colors.white,
                  size: 28,
                ),
                onPressed: () => _fijarFav(popular),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: popular.starRating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${popular.voteAverage.toStringAsFixed(1)}/10',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  
                  Text(
                    'Sinopsis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    popular.overview,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  if (videos.isNotEmpty) ...[
                    Text(
                      'Trailers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return Container(
                            width: 200,
                            margin: EdgeInsets.only(right: 15),
                            child: GestureDetector(
                              onTap: () => _playVideoInternally(video.key),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      video.thumbnailUrl,
                                      width: 200,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                  
                  if (actors.isNotEmpty) ...[
                    Text(
                      'Reparto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: actors.length,
                        itemBuilder: (context, index) {
                          final actor = actors[index];
                          return Container(
                            width: 120,
                            margin: EdgeInsets.only(right: 15),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    actor.fullProfilePath,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  actor.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  actor.character,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  
                  if (cargando)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}