import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../models/movie.dart';
import '../theme/app_colors.dart';
import '../../features/discovery/providers/movie_provider.dart';
import '../../features/watchlist/providers/watchlist_provider.dart';
import '../../features/discovery/widgets/movie_detail_modal.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double? width;
  final bool showActions;

  const MovieCard({
    super.key,
    required this.movie,
    this.width,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          builder: (context) => MovieDetailModal(movie: movie),
        );
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Movie Poster
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [AppColors.cardShadow],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: movie.posterUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        color: AppColors.lightPurple,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.lightPurple,
                        child: const Icon(
                          Icons.movie_rounded,
                          size: 50,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                  ),
                ),

                // Action Buttons
                if (showActions)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      children: [
                        _buildActionButton(
                          context,
                          icon: Icons.favorite,
                          color: AppColors.like,
                          onPressed: () {
                            context.read<MovieProvider>().toggleLike(movie);
                          },
                          isActive: context.watch<MovieProvider>().isLiked(movie),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          context,
                          icon: Icons.bookmark,
                          color: AppColors.saved,
                          onPressed: () {
                            final provider = context.read<WatchlistProvider>();
                            if (provider.isInWatchlist(movie)) {
                              provider.removeFromWatchlist(movie);
                            } else {
                              provider.addToWatchlist(movie);
                            }
                          },
                          isActive: context.watch<WatchlistProvider>().isInWatchlist(movie),
                        ),
                      ],
                    ),
                  ),

                // Rating Badge
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppColors.rating, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${movie.year} • ${movie.durationFormatted}',
              style: TextStyle(
                fontSize: 12,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? color : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 18,
          color: isActive ? Colors.white : color,
        ),
      ),
    );
  }
}
