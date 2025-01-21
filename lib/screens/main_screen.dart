import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:day_1/screens/details_screen.dart';
import 'package:day_1/screens/favorites_screen.dart';
import 'package:day_1/screens/home_screen.dart';
import 'package:day_1/screens/onboarding_screen.dart';
import 'package:day_1/screens/search_screen.dart';
import 'package:day_1/screens/seemore_screen.dart';
import 'package:day_1/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        FontAwesomeIcons.house,
        color: Colors.white,
      ),
      const Icon(
        FontAwesomeIcons.magnifyingGlass,
        color: Colors.white,
      ),
      const Icon(
        FontAwesomeIcons.heart,
        color: Colors.white,
      ),
      const Icon(
        FontAwesomeIcons.bookOpen,
        color: Colors.white,
      ),
    ];
    final pages = <Widget>[
      const HomeScreen(),
      const SearchScreen(),
      const FavoritesScreen(),
      const SeemoreScreen(),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.transparent,
        height: 55,
        items: items,
        index: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
