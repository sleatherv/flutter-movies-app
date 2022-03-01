
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'fe3645cf9bed3ff625f6344c89102ffa';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  MoviesProvider(){
    print('MoviesProvider initialized');
    getOnDisplayMovies();
  }
    getOnDisplayMovies() async{
      var url = Uri.https(_baseUrl, '3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',

      });
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      final Map<String, dynamic> decodedData = convert.jsonDecode(response.body);
      print(decodedData['dates']);
    }
}
