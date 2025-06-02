class ActorModel {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  ActorModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory ActorModel.fromMap(Map<String, dynamic> actor) {
    return ActorModel(
      adult: actor['adult'] ?? false,
      gender: actor['gender'] ?? 0,
      id: actor['id'] ?? 0,
      knownForDepartment: actor['known_for_department'] ?? '',
      name: actor['name'] ?? '',
      originalName: actor['original_name'] ?? '',
      popularity: (actor['popularity'] ?? 0).toDouble(),
      profilePath: actor['profile_path'],
      castId: actor['cast_id'] ?? 0,
      character: actor['character'] ?? '',
      creditId: actor['credit_id'] ?? '',
      order: actor['order'] ?? 0,
    );
  }

  // Método para obtener la URL completa de la imagen del actor
  String get fullProfilePath {
    if (profilePath != null && profilePath!.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w185$profilePath';
    }
    return 'https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-5529.jpg';
  }
}