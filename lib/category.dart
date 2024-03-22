import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identifier/cat_widget/catPage.dart';
import 'package:identifier/dog_widget/dogPage.dart';

class Categories extends StatefulWidget {
  final void Function(int index) onCategorySelected;

  const Categories({
    required this.onCategorySelected,
    Key? key,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Dog", "Cat"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        // Notifier le parent lorsqu'une catégorie est sélectionnée
        widget.onCategorySelected(index);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: selectedIndex == index ? Colors.black : Colors.orange,
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color: selectedIndex == index ? Colors.black : Colors.black,
                fontSize: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
