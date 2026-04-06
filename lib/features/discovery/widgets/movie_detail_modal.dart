import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/movie.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/movie_provider.dart';
import '../../watchlist/providers/watchlist_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailModal extends StatelessWidget {
  final Movie movie;

  const MovieDetailModal({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.cardColor;
    final titleColor = theme.textTheme.titleLarge?.color ?? AppColors.textPrimary;
    final secondaryText = theme.textTheme.bodyMedium?.color ?? AppColors.textSecondary;
    final chipBg = isDark ? const Color(0xFF2A1D44) : AppColors.lightPurple;
    final chipText = isDark ? const Color(0xFFE6DBFF) : AppColors.primaryPurple;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(0),
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.dividerColor.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Movie Poster
              Container(
                height: 300,
                margin: const EdgeInsets.all(20),
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
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Meta Info
                    Row(
                      children: [
                        Text(
                          movie.year.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryText,
                          ),
                        ),
                        Text(' • ', style: TextStyle(color: secondaryText)),
                        Text(
                          movie.durationFormatted,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryText,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: AppColors.rating, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Genres
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genres.map((genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: chipBg,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            genre,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: chipText,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<WatchlistProvider>(
                            builder: (context, provider, _) {
                              final isInWatchlist = provider.isInWatchlist(movie);
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (isInWatchlist) {
                                    provider.removeFromWatchlist(movie);
                                  } else {
                                    provider.addToWatchlist(movie);
                                  }
                                },
                                icon: Icon(
                                  isInWatchlist ? Icons.check : Icons.add,
                                ),
                                label: Text(isInWatchlist ? 'In Watchlist' : 'Add to Watchlist'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Consumer<MovieProvider>(
                          builder: (context, provider, _) {
                            final isLiked = provider.isLiked(movie);
                            return IconButton(
                              onPressed: () {
                                provider.toggleLike(movie);
                              },
                              icon: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? AppColors.like : AppColors.textMuted,
                              ),
                              iconSize: 28,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
