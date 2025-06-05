import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    // Validar que el videoId no esté vacío
    if (widget.videoId.isEmpty) {
      print('Error: videoId está vacío');
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Cambiado a false para evitar problemas
        mute: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Verificar si el videoId es válido
    if (widget.videoId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Video no disponible',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'El ID del video no es válido',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproduciendo trailer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {
              setState(() {
                _isPlayerReady = true;
              });
              print('Player is ready');
            },
            onEnded: (data) {
              print('Video ended');
            },
          ),
          const SizedBox(height: 20),
          if (!_isPlayerReady)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando video...'),
                ],
              ),
            ),
          // Botones de control adicionales
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _controller.play(),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.pause(),
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// detail_popular_movie_screen.dart - Método corregido para reproducir video
void _playVideoInternally(String videoKey, BuildContext context) {
  // Validar que el videoKey no esté vacío antes de navegar
  if (videoKey.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoId: videoKey),
      ),
    );
  } else {
    // Mostrar mensaje de error si no hay video disponible
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Video no disponible'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}