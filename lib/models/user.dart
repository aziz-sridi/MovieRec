class User {
  final String id;
  final String name;
  final String avatarEmoji;
  final String avatarColor;
  final List<String> preferredGenres;
  final List<String> watchlistIds;
  final List<String> likedMovieIds;
  final List<String> watchedMovieIds;

  User({
    required this.id,
    required this.name,
    required this.avatarEmoji,
    required this.avatarColor,
    required this.preferredGenres,
    required this.watchlistIds,
    required this.likedMovieIds,
    required this.watchedMovieIds,
  });

  User copyWith({
    String? name,
    String? avatarEmoji,
    String? avatarColor,
    List<String>? preferredGenres,
    List<String>? watchlistIds,
    List<String>? likedMovieIds,
    List<String>? watchedMovieIds,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      avatarEmoji: avatarEmoji ?? this.avatarEmoji,
      avatarColor: avatarColor ?? this.avatarColor,
      preferredGenres: preferredGenres ?? this.preferredGenres,
      watchlistIds: watchlistIds ?? this.watchlistIds,
      likedMovieIds: likedMovieIds ?? this.likedMovieIds,
      watchedMovieIds: watchedMovieIds ?? this.watchedMovieIds,
    );
  }
}
