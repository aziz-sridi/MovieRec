import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/watchlist_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/watchlist_item.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Consumer<WatchlistProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Watchlist',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                ),
                Text(
                  '${provider.watchlistCount} movies',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Consumer<WatchlistProvider>(
        builder: (context, provider, _) {
          if (provider.watchlist.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 80,
                    color: AppColors.lightPurple,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No movies in watchlist',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start adding movies to watch later',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.watchlist.length,
            itemBuilder: (context, index) {
              final movie = provider.watchlist[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < provider.watchlist.length - 1 ? 16 : 0,
                ),
                child: WatchlistItem(movie: movie),
              );
            },
          );
        },
      ),
    );
  }
}
