// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:identifier/Identifier.dart';
import 'package:identifier/cat_widget/catPage.dart';
import 'package:identifier/dog_widget/dogPage.dart';
import 'package:identifier/home.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_selectedIndex),
      bottomNavigationBar: Container(
        height: 55,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Couleur de l'ombre
              spreadRadius: 1, // Rayon de dispersion de l'ombre
              blurRadius: 5, // Rayon de flou de l'ombre
              offset: const Offset(
                  0, 2), // Décalage de l'ombre par rapport au conteneur
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: const Icon(Icons.home),
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: const Icon(Icons.photo_camera),
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Identifier();
      default:
        return Container();
    }
  }
}
