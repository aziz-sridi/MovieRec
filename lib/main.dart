import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/providers/app_settings_provider.dart';
import 'features/discovery/providers/movie_provider.dart';
import 'features/watchlist/providers/watchlist_provider.dart';
import 'features/profile/providers/profile_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MovieRecApp());
}

class MovieRecApp extends StatelessWidget {
  const MovieRecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
      ],
      child: Consumer<AppSettingsProvider>(
        builder: (context, settingsProvider, _) {
          return MaterialApp.router(
            title: 'MovieRec',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
