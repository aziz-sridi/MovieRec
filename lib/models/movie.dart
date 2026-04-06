class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final List<String> genres;
  final int duration; // in minutes
  final double rating;
  final int year;
  final String description;
  final String? trailerUrl;
  final List<String> moodTags;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.genres,
    required this.duration,
    required this.rating,
    required this.year,
    required this.description,
    this.trailerUrl,
    required this.moodTags,
  });

  String get durationFormatted {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }
}
