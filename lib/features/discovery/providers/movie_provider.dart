import 'package:flutter/foundation.dart';
import '../../../models/movie.dart';
import '../../../data/mock_data.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _allMovies = MockData.movies;
  List<Movie> _likedMovies = [];
  String _selectedMood = 'All';

  List<Movie> get allMovies => _allMovies;
  List<Movie> get likedMovies => _likedMovies;
  String get selectedMood => _selectedMood;

  List<Movie> get trendingMovies => _allMovies.take(6).toList();

  List<Movie> get filteredByMood {
    if (_selectedMood == 'All') return _allMovies;
    return _allMovies
        .where((movie) => movie.moodTags.any((tag) => tag.toLowerCase().contains(_selectedMood.toLowerCase())))
        .toList();
  }

  List<Movie> get recommendedMovies {
    if (_likedMovies.isEmpty) return _allMovies.take(4).toList();
    
    final likedGenres = _likedMovies
        .expand((movie) => movie.genres)
        .toSet()
        .toList();

    final recommended = _allMovies
        .where((movie) => 
          !_likedMovies.contains(movie) &&
          movie.genres.any((genre) => likedGenres.contains(genre))
        )
        .toList();

    return recommended.take(4).toList();
  }

  void setMoodFilter(String mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void toggleLike(Movie movie) {
    if (_likedMovies.contains(movie)) {
      _likedMovies.remove(movie);
    } else {
      _likedMovies.add(movie);
    }
    notifyListeners();
  }

  bool isLiked(Movie movie) {
    return _likedMovies.contains(movie);
  }

  Movie getMovieById(String id) {
    return _allMovies.firstWhere((movie) => movie.id == id);
  }
}
