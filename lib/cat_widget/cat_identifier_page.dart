import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class catBreedIdentifierPage extends StatefulWidget {
  @override
  _catBreedIdentifierPageState createState() => _catBreedIdentifierPageState();
}

class _catBreedIdentifierPageState extends State<catBreedIdentifierPage> {
  File? _imageFile;
  String? _catBreed;
  double? _catScore;
  final picker = ImagePicker();
  final apiUrl = 'http://192.168.88.21:5000/infer-cat'; // URL de l'API Flask
  final apiKey = 'QHL5psNHyJiFsvWBeMeo';

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _catBreed = null;
        _catScore = null;
      });

      await _classifyImage(_imageFile!);
    }
  }

  Future<void> _classifyImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes); // Convert to base64

      // Create objet Map with data images
      Map<String, dynamic> imageMap = {
        'image': base64Image,
      };

      // Convert objet Map to JSON
      String jsonData = jsonEncode(imageMap);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type':
              'application/json', // Utiliser 'application/json' pour le type de contenu
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> predictions = responseData['predictions'];
        // Vérifier si des prédictions existent
        if (predictions.isNotEmpty) {
          // Récupérer la première prédiction (indice 0)
          Map<String, dynamic> firstPrediction = predictions[0];
          // Accéder aux valeurs spécifiques de la prédiction
          String breed = firstPrediction['class'];
          double rawScore = firstPrediction['confidence']; // Score brut
          // Multiplier le score par 1000 et l'afficher en pourcentage
          double score = rawScore * 100;
          setState(() {
            _catBreed = breed;
            _catScore = score;
          });
        } else {
          print('No predictions found in response');
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cat Breed Identifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : Text('No image selected.'),
            SizedBox(height: 20),
            _catBreed != null
                ? Column(
                    children: [
                      Text('Breed: $_catBreed'),
                      Text('Score: ${(_catScore ?? 0.0).toStringAsFixed(2)}%'),
                    ],
                  )
                : SizedBox(),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
