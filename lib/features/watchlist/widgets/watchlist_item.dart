import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/movie.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/watchlist_provider.dart';

class WatchlistItem extends StatelessWidget {
  final Movie movie;

  const WatchlistItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistProvider>(
      builder: (context, provider, _) {
        final isWatched = provider.isWatched(movie);

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [AppColors.cardShadow],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Movie Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${movie.year} • ${movie.durationFormatted}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: movie.genres.take(2).map((genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            genre,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.rating, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            provider.toggleWatched(movie);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: isWatched
                                ? AppColors.success.withOpacity(0.1)
                                : AppColors.lightPurple,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          child: Text(
                            isWatched ? 'Watched' : 'Mark Watched',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isWatched ? AppColors.success : AppColors.primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Delete Button
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                color: AppColors.textMuted,
                onPressed: () {
                  provider.removeFromWatchlist(movie);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
