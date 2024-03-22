import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final Map<String, dynamic>? cat;

  const CatCard({this.cat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cat == null || cat!['imgThumb'] == null || cat!['breedName'] == null) {
      // Si les données du chat sont nulles ou manquantes, afficher un message ou un widget alternatif
      return Container(
        child: Text('Données du chat non disponibles'),
      );
    }

    return Column(
      children: [
        Container(
          child: Image.network(
            cat!['imgThumb'],
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          cat!['breedName'],
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
