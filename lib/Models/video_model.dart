class VideoModel {
  String id;
  String key;
  String name;
  String site;
  int size;
  String type;
  bool official;
  String publishedAt;

  VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  factory VideoModel.fromMap(Map<String, dynamic> video) {
    return VideoModel(
      id: video['id'] ?? '',
      key: video['key'] ?? '',
      name: video['name'] ?? '',
      site: video['site'] ?? '',
      size: video['size'] ?? 0,
      type: video['type'] ?? '',
      official: video['official'] ?? false,
      publishedAt: video['published_at'] ?? '',
    );
  }

  // Método para obtener la URL del video de YouTube
  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';
  
  // Método para obtener la URL de thumbnail de YouTube
  String get thumbnailUrl => 'https://img.youtube.com/vi/$key/maxresdefault.jpg';
}