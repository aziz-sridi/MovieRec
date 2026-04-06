import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';

class HelpChooseScreen extends StatefulWidget {
  const HelpChooseScreen({super.key});

  @override
  State<HelpChooseScreen> createState() => _HelpChooseScreenState();
}

class _HelpChooseScreenState extends State<HelpChooseScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _showGroupPanel = false;

  @override
  void deactivate() {
    _showGroupPanel = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final panelBg = isDark ? const Color(0xFF170F26) : Colors.white;
    final panelTitleColor = isDark ? Colors.white : AppColors.textPrimary;
    final panelSecondaryColor = isDark ? const Color(0xFFC9B9E8) : AppColors.textSecondary;
    final panelInputFill = isDark ? const Color(0xFF24183A) : const Color(0xFFF3EEFF);
    final panelBorderColor = isDark ? const Color(0xFFA78BFA) : AppColors.primaryPurple;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let\'s Pick a Movie',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.headlineMedium?.color,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Solo or with friends?',
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.textTheme.bodyMedium?.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 640;

                        final soloCard = _ModeCard(
                          icon: Icons.person_rounded,
                          title: 'Solo',
                          description: 'Find something just for you',
                          ctaLabel: 'Start',
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () {
                            final randomMovie = (MockData.movies..shuffle()).first;
                            context.push('/match-result', extra: randomMovie.id);
                          },
                        );

                        final groupCard = _ModeCard(
                          icon: Icons.groups_rounded,
                          title: 'With Friends',
                          description: 'Pick together, no arguing',
                          ctaLabel: 'Start Session',
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6D28D9), Color(0xFF4F46E5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          onTap: () {
                            setState(() {
                              _showGroupPanel = true;
                            });
                          },
                        );

                        if (isCompact) {
                          return Column(
                            children: [
                              Expanded(child: soloCard),
                              const SizedBox(height: 14),
                              Expanded(child: groupCard),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(child: soloCard),
                            const SizedBox(width: 14),
                            Expanded(child: groupCard),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_showGroupPanel)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showGroupPanel = false;
                    });
                  },
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              left: 0,
              right: 0,
              bottom: _showGroupPanel ? 0 : -520,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: panelBg,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        16,
                        20,
                        20 + MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF7A6A98) : const Color(0xFFD6C6F7),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Start a session',
                              style: TextStyle(
                                fontSize: 22,
                                color: panelTitleColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showGroupPanel = false;
                                  _codeController.text = 'MOVIE123';
                                });
                                _showInfo(context, 'Room created. Share code MOVIE123');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Create Room'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'You\'ll invite others',
                            style: TextStyle(color: panelSecondaryColor, fontSize: 12),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: isDark ? const Color(0xFF47365D) : const Color(0xFFDCCFF4),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('or', style: TextStyle(color: panelSecondaryColor)),
                              ),
                              Expanded(
                                child: Divider(
                                  color: isDark ? const Color(0xFF47365D) : const Color(0xFFDCCFF4),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Join with Code',
                            style: TextStyle(
                              color: panelTitleColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _codeController,
                            style: TextStyle(color: panelTitleColor),
                            decoration: InputDecoration(
                              hintText: 'Enter room code',
                              hintStyle: TextStyle(color: panelSecondaryColor),
                              filled: true,
                              fillColor: panelInputFill,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                final code = _codeController.text.trim();
                                if (code.isEmpty) {
                                  _showInfo(context, 'Please enter a room code.');
                                  return;
                                }
                                setState(() {
                                  _showGroupPanel = false;
                                });
                                _showInfo(context, 'Joined room $code');
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: panelTitleColor,
                                side: BorderSide(color: panelBorderColor),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Join'),
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _showGroupPanel = false;
                                });
                                _showInfo(context, 'Opening camera for QR scan...');
                              },
                              icon: Icon(Icons.qr_code_scanner_rounded, color: panelTitleColor),
                              label: Text(
                                'Scan QR Code',
                                style: TextStyle(color: panelTitleColor),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: panelInputFill,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryPurple,
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String ctaLabel;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.ctaLabel,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.24),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    label: Text(ctaLabel),
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.white.withOpacity(0.18),
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
