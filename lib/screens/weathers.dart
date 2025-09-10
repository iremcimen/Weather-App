import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/widgets/home.dart';
import 'package:weather_app/widgets/weather_form.dart';
import 'dart:ui';

class WeathersScreen extends ConsumerStatefulWidget {
  const WeathersScreen({super.key});
  @override
  ConsumerState<WeathersScreen> createState() {
    return _WeathersScreenState();
  }
}

class _WeathersScreenState extends ConsumerState<WeathersScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = Home();

    if (_selectedPageIndex == 1) {
      activePage = WeatherForm();
    }
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/sunny.jpg",
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.blue.withAlpha(50),
                BlendMode.softLight,
              ),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50.withAlpha(175),
                Colors.white.withAlpha(127),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: activePage,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 16, right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withAlpha(230),
                        Colors.blue.shade50.withAlpha(230),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.shade200.withAlpha(65),
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: BottomNavigationBar(
                    onTap: _selectPage,
                    currentIndex: _selectedPageIndex,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.deepOrangeAccent,
                    unselectedItemColor: Colors.blueGrey.shade400,
                    selectedLabelStyle: Theme.of(
                      context,
                    ).bottomNavigationBarTheme.selectedLabelStyle,
                    unselectedLabelStyle: Theme.of(
                      context,
                    ).bottomNavigationBarTheme.unselectedLabelStyle,
                    showUnselectedLabels: true,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home, size: 28),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search_outlined),
                        activeIcon: Icon(Icons.search, size: 28),
                        label: 'Search',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
