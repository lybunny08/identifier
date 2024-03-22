import 'package:flutter/material.dart';
import 'package:identifier/cat_widget/catPage.dart';
import 'package:identifier/category.dart';
import 'package:identifier/dog_widget/dogPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Categories(
            onCategorySelected: (index) {
              // Mettre à jour l'index de la page actuelle
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Expanded(
            child: _buildCurrentPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return DogListPage();
      case 1:
        return CatListPage();
      default:
        return Container(); // Placeholder for unknown index
    }
  }
}
