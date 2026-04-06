import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';

class MoodFilter extends StatelessWidget {
  const MoodFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildMoodChip(context, 'All', provider.selectedMood == 'All', () {
                provider.setMoodFilter('All');
              }),
              const SizedBox(width: 8),
              ...MockData.moodCategories.map((mood) {
                final isSelected = provider.selectedMood == mood;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildMoodChip(context, mood, isSelected, () {
                    provider.setMoodFilter(mood);
                  }),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoodChip(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.lightPurple,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
