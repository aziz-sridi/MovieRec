import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/discovery/screens/discovery_screen.dart';
import '../../features/help_choose/screens/help_choose_screen.dart';
import '../../features/help_choose/screens/match_result_screen.dart';
import '../../features/watchlist/screens/watchlist_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../widgets/custom_bottom_nav.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return CustomBottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage(
            child: DiscoveryScreen(),
          ),
        ),
        GoRoute(
          path: '/help',
          pageBuilder: (context, state) => NoTransitionPage(
            child: HelpChooseScreen(),
          ),
        ),
        GoRoute(
          path: '/watchlist',
          pageBuilder: (context, state) => NoTransitionPage(
            child: WatchlistScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/match-result',
      builder: (context, state) {
        final movieId = state.extra as String?;
        return MatchResultScreen(movieId: movieId ?? '1');
      },
    ),
  ],
);
