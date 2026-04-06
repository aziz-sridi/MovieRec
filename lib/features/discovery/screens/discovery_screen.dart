import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/movie_card.dart';
import '../widgets/mood_filter.dart';
import '../../../data/mock_data.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              title: Text(
                'Suggested For You',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    // TODO: Implement search
                  },
                ),
              ],
            ),

            // Trending Now Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending Now',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<MovieProvider>(
                      builder: (context, provider, _) {
                        return SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.trendingMovies.length,
                            itemBuilder: (context, index) {
                              final movie = provider.trendingMovies[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index < provider.trendingMovies.length - 1 ? 16 : 0,
                                ),
                                child: MovieCard(movie: movie, width: 160),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Recommended For You Section
            SliverToBoxAdapter(
              child: Consumer<MovieProvider>(
                builder: (context, provider, _) {
                  if (provider.likedMovies.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Just For You',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.recommendedMovies.length,
                            itemBuilder: (context, index) {
                              final movie = provider.recommendedMovies[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index < provider.recommendedMovies.length - 1 ? 16 : 0,
                                ),
                                child: MovieCard(movie: movie, width: 160),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // By Mood Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'By Mood',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: MoodFilter(),
            ),

            // Quick Picks Grid
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: Consumer<MovieProvider>(
                builder: (context, provider, _) {
                  final movies = provider.filteredByMood;
                    return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return MovieCard(movie: movies[index]);
                      },
                      childCount: movies.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Random movie feature
          final randomMovie = (MockData.movies..shuffle()).first;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('How about "${randomMovie.title}"?'),
              backgroundColor: AppColors.primaryPurple,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(Icons.shuffle_rounded),
        label: const Text('Random'),
        backgroundColor: AppColors.primaryPurple,
      ),
    );
  }
}
