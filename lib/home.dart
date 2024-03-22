import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identifier/cat_widget/catPage.dart';
import 'package:identifier/dog_widget/dogPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Item()],
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getBody(_selectedIndex),
        ],
      ),
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
              icon: const Icon(Icons.favorite),
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              icon: const Icon(Icons.person),
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return DogListPage();
      case 1:
        return CatListPage();
      default:
        return Container();
    }
  }
}
