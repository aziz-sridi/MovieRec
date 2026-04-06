import 'package:flutter/foundation.dart';
import '../../../models/user.dart';
import '../../../data/mock_data.dart';

class ProfileProvider extends ChangeNotifier {
  User _currentUser = MockData.currentUser;
  bool _notificationsEnabled = true;
  String _language = 'English';
  final List<String> _watchedHistoryIds = List<String>.from(MockData.currentUser.watchedMovieIds);

  User get currentUser => _currentUser;
  bool get notificationsEnabled => _notificationsEnabled;
  String get language => _language;
  List<String> get watchedHistoryIds => List.unmodifiable(_watchedHistoryIds);

  void updateAvatar(String emoji, String color) {
    _currentUser = _currentUser.copyWith(
      avatarEmoji: emoji,
      avatarColor: color,
    );
    notifyListeners();
  }

  void updateName(String name) {
    _currentUser = _currentUser.copyWith(name: name);
    notifyListeners();
  }

  void toggleGenrePreference(String genre) {
    final genres = List<String>.from(_currentUser.preferredGenres);
    if (genres.contains(genre)) {
      genres.remove(genre);
    } else {
      genres.add(genre);
    }
    _currentUser = _currentUser.copyWith(preferredGenres: genres);
    notifyListeners();
  }

  bool isGenrePreferred(String genre) {
    return _currentUser.preferredGenres.contains(genre);
  }

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  void addWatchedMovie(String movieId) {
    if (_watchedHistoryIds.contains(movieId)) return;
    _watchedHistoryIds.insert(0, movieId);
    notifyListeners();
  }
}
