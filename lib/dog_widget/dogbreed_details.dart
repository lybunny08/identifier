import 'package:flutter/material.dart';

class DogDetailsPage extends StatelessWidget {
  final Map<String, dynamic> dog;

  const DogDetailsPage({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog['breedName']),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              dog['imgThumb'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Breed Type: ${dog['breedType']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Description: ${dog['breedDescription']}'),
            SizedBox(height: 16.0),
            Text('Origin: ${dog['origin']}'),
            SizedBox(height: 16.0),
            Text('Fur Color: ${dog['furColor']}'),
            SizedBox(height: 16.0),
            Text(
                'Life Span: ${dog['minLifeSpan']} - ${dog['maxLifeSpan']} years'),
            SizedBox(height: 16.0),
            Text(
                'Weight: ${dog['minWeightPounds']} - ${dog['maxWeightPounds']} pounds'),
          ],
        ),
      ),
    );
  }
}
