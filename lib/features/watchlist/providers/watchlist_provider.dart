import 'package:flutter/foundation.dart';
import '../../../models/movie.dart';

class WatchlistProvider extends ChangeNotifier {
  final List<Movie> _watchlist = [];
  final Set<String> _watchedMovieIds = {};

  List<Movie> get watchlist => _watchlist;

  void addToWatchlist(Movie movie) {
    if (!_watchlist.contains(movie)) {
      _watchlist.add(movie);
      notifyListeners();
    }
  }

  void removeFromWatchlist(Movie movie) {
    _watchlist.remove(movie);
    _watchedMovieIds.remove(movie.id);
    notifyListeners();
  }

  bool isInWatchlist(Movie movie) {
    return _watchlist.contains(movie);
  }

  void toggleWatched(Movie movie) {
    if (_watchedMovieIds.contains(movie.id)) {
      _watchedMovieIds.remove(movie.id);
    } else {
      _watchedMovieIds.add(movie.id);
    }
    notifyListeners();
  }

  bool isWatched(Movie movie) {
    return _watchedMovieIds.contains(movie.id);
  }

  int get watchlistCount => _watchlist.length;
  int get watchedCount => _watchedMovieIds.length;
}
