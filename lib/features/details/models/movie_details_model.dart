class MovieDetails {
  final String title;
  final String overview;
  final String releaseDate;
  final String backdropPath;
  final double voteAverage;
  final int runtime;
  final List<String> genres;

  MovieDetails({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.backdropPath,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => genre['name'] as String)
          .toList(),
    );
  }
}