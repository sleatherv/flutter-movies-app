
import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar película'; //Change search label language

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          close(context, null);
        }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100),
      );
    }
    return Container();
  }

}