import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNav extends StatefulWidget {
  final Widget child;

  const CustomBottomNav({super.key, required this.child});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/help');
        break;
      case 2:
        context.go('/watchlist');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    
    // Update current index based on location
    if (location == '/') {
      _currentIndex = 0;
    } else if (location == '/help') {
      _currentIndex = 1;
    } else if (location == '/watchlist') {
      _currentIndex = 2;
    } else if (location == '/profile') {
      _currentIndex = 3;
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_outlined),
              activeIcon: Icon(Icons.auto_awesome_rounded),
              label: 'For You',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_rounded),
              activeIcon: Icon(Icons.help_rounded),
              label: 'Help Me',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded),
              activeIcon: Icon(Icons.bookmark_rounded),
              label: 'Watchlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
