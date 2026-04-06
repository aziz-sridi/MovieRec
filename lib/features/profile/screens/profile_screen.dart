import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../../discovery/providers/movie_provider.dart';
import '../../watchlist/providers/watchlist_provider.dart';
import '../../../core/providers/app_settings_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../models/movie.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _preferencesExpanded = true;
  bool _historyExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final cardShadow = isDark ? <BoxShadow>[] : <BoxShadow>[AppColors.cardShadow];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primaryPurple,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                child: SafeArea(
                  child: Consumer<ProfileProvider>(
                    builder: (context, provider, _) {
                      final user = provider.currentUser;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Center(child: Text(user.avatarEmoji, style: const TextStyle(fontSize: 40))),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<MovieProvider>(
                                builder: (_, movieProvider, __) =>
                                    _buildStat('Liked', movieProvider.likedMovies.length.toString()),
                              ),
                              const SizedBox(width: 32),
                              Consumer<WatchlistProvider>(
                                builder: (_, watchlistProvider, __) =>
                                    _buildStat('Watchlist', watchlistProvider.watchlistCount.toString()),
                              ),
                              const SizedBox(width: 32),
                              Consumer<ProfileProvider>(
                                builder: (_, profileProvider, __) =>
                                    _buildStat('History', profileProvider.watchedHistoryIds.length.toString()),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildPreferencesSection(context, cardColor, cardShadow),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<MovieProvider>(
              builder: (context, provider, _) {
                if (provider.likedMovies.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Liked Movies',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.titleLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.likedMovies.length,
                          itemBuilder: (context, index) {
                            final movie = provider.likedMovies[index];
                            return Padding(
                              padding: EdgeInsets.only(right: index < provider.likedMovies.length - 1 ? 12 : 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  movie.posterUrl,
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildHistorySection(context, cardColor, cardShadow),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.person_outline,
                    title: 'Account Settings',
                    subtitle: 'Manage your profile details',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy',
                    subtitle: 'Control sharing and visibility',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context, Color cardColor, List<BoxShadow> boxShadow) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(14), boxShadow: boxShadow),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _preferencesExpanded = !_preferencesExpanded),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                ),
                Icon(_preferencesExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
          if (_preferencesExpanded) ...[
            const SizedBox(height: 12),
            Consumer<ProfileProvider>(
              builder: (context, provider, _) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.notifications_active_outlined, color: AppColors.primaryPurple),
                title: const Text('Notifications'),
                subtitle: const Text('Get updates for picks and sessions'),
                value: provider.notificationsEnabled,
                onChanged: provider.setNotificationsEnabled,
              ),
            ),
            Consumer<AppSettingsProvider>(
              builder: (context, settingsProvider, _) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.dark_mode_outlined, color: AppColors.primaryPurple),
                title: const Text('Dark Theme'),
                subtitle: const Text('Switch between light and dark'),
                value: settingsProvider.isDarkMode,
                onChanged: settingsProvider.setDarkMode,
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (context, provider, _) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language_rounded, color: AppColors.primaryPurple),
                title: const Text('Language'),
                subtitle: const Text('Choose app language'),
                trailing: DropdownButton<String>(
                  value: provider.language,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'French', child: Text('French')),
                    DropdownMenuItem(value: 'Arabic', child: Text('Arabic')),
                  ],
                  onChanged: (value) {
                    if (value != null) provider.setLanguage(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preferred Genres',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 10),
            Consumer<ProfileProvider>(
              builder: (context, provider, _) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MockData.allGenres.map((genre) {
                    final isSelected = provider.isGenrePreferred(genre);
                    return GestureDetector(
                      onTap: () => provider.toggleGenrePreference(genre),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.primaryGradient : null,
                          color: isSelected ? null : AppColors.palePurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          genre,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context, Color cardColor, List<BoxShadow> boxShadow) {
    final theme = Theme.of(context);
    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        final historyMovies = provider.watchedHistoryIds
            .map((id) => MockData.movies.where((m) => m.id == id).toList())
            .where((list) => list.isNotEmpty)
            .map((list) => list.first)
            .toList();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(14), boxShadow: boxShadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => setState(() => _historyExpanded = !_historyExpanded),
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Watched History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.titleMedium?.color,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _showAddHistoryDialog(context),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add'),
                    ),
                    Icon(_historyExpanded ? Icons.expand_less : Icons.expand_more),
                  ],
                ),
              ),
              if (_historyExpanded) ...[
                if (historyMovies.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'No history yet. Add movies you watched before installing the app.',
                      style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                    ),
                  )
                else
                  ...historyMovies.take(6).map(_buildHistoryItem),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoryItem(Movie movie) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(movie.posterUrl, width: 44, height: 66, fit: BoxFit.cover),
      ),
      title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${movie.year} • ${movie.genres.take(2).join(', ')}'),
    );
  }

  void _showAddHistoryDialog(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    final existing = profileProvider.watchedHistoryIds.toSet();
    final allCandidates = MockData.movies.where((movie) => !existing.contains(movie.id)).toList();
    final queryController = TextEditingController();
    String query = '';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final candidates = allCandidates
                .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
                .toList();

            return AlertDialog(
              title: const Text('Add watched movie'),
              content: SizedBox(
                width: 460,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: queryController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'Search movies',
                      ),
                      onChanged: (value) => setDialogState(() => query = value),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: candidates.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text('No matching movies found.'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: candidates.length,
                              separatorBuilder: (_, __) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final movie = candidates[index];
                                return ListTile(
                                  title: Text(movie.title),
                                  subtitle: Text('${movie.year} • ${movie.genres.first}'),
                                  trailing: const Icon(Icons.add_circle_outline_rounded),
                                  onTap: () {
                                    profileProvider.addWatchedMovie(movie.id);
                                    Navigator.pop(dialogContext);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(queryController.dispose);
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryPurple),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right, color: theme.textTheme.bodySmall?.color),
        onTap: onTap,
      ),
    );
  }
}
