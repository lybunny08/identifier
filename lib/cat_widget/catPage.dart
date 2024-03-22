import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:identifier/cat_widget/catbreed_details.dart';

class CatListPage extends StatefulWidget {
  @override
  _CatListPageState createState() => _CatListPageState();
}

class _CatListPageState extends State<CatListPage> {
  late List<Map<String, dynamic>> catsList;
  late List<Map<String, dynamic>> filteredDogsList = [];

  @override
  void initState() {
    super.initState();
    fetchDogData();
  }

  Future<void> fetchDogData() async {
    final response = await http.get(
      Uri.parse('https://catbreeddb.p.rapidapi.com/'),
      headers: {
        'X-RapidAPI-Key': '29f191f415mshdba5f9c936acf9ep1d26f3jsnfa8e7dd958e5',
        'X-RapidAPI-Host': 'catbreeddb.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        catsList = List<Map<String, dynamic>>.from(data);
        filteredDogsList = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load dog data');
    }
  }

  void filterDogsList(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDogsList = List<Map<String, dynamic>>.from(catsList);
      });
    } else {
      setState(() {
        filteredDogsList = catsList
            .where((cat) =>
                cat['breedName'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat List'),
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
              child: Image.asset(
                'assets/loadingcat.gif',
                width: MediaQuery.of(context).size.width / 2.2,
                height: MediaQuery.of(context).size.width / 2.5,
                fit: BoxFit.cover,
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredDogsList.length,
              itemBuilder: (context, index) {
                final cat = filteredDogsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatDetailsPage(cat: cat),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              cat['imgThumb'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Flexible(
                          child: Text(
                            cat['breedName'],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
