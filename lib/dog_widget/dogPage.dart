import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogListPage extends StatefulWidget {
  @override
  _DogListPageState createState() => _DogListPageState();
}

class _DogListPageState extends State<DogListPage> {
  late List<Map<String, dynamic>> dogsList;
  late List<Map<String, dynamic>> filteredDogsList = [];

  @override
  void initState() {
    super.initState();
    fetchDogData();
  }

  Future<void> fetchDogData() async {
    final response = await http.get(
      Uri.parse('https://dogbreeddb.p.rapidapi.com/'),
      headers: {
        'X-RapidAPI-Key': '29f191f415mshdba5f9c936acf9ep1d26f3jsnfa8e7dd958e5',
        'X-RapidAPI-Host': 'dogbreeddb.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        dogsList = List<Map<String, dynamic>>.from(data);
        filteredDogsList = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load dog data');
    }
  }

  void filterDogsList(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDogsList = List<Map<String, dynamic>>.from(dogsList);
      });
    } else {
      setState(() {
        filteredDogsList = dogsList
            .where((dog) =>
                dog['breedName'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? query = await showSearch<String?>(
                context: context,
                delegate: DogSearchDelegate(),
              );
              if (query != null) {
                filterDogsList(query);
              }
            },
          ),
        ],
      ),
      body: filteredDogsList.isEmpty
          ? Center(
              child: SizedBox(
                child: Image.asset(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.width / 2.5,
                  'assets/dogload.gif',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: filteredDogsList.length,
              itemBuilder: (context, index) {
                final dog = filteredDogsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DogDetailsPage(dog: dog),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        dog['imgThumb'],
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        dog['breedName'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class DogSearchDelegate extends SearchDelegate<String?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Build results for query: $query');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('Build suggestions for query: $query');
  }
}

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
