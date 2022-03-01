
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';


class MoviesProvider extends ChangeNotifier{

  final String _apiKey = 'fe3645cf9bed3ff625f6344c89102ffa';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    // print('MoviesProvider initialized');
    getOnDisplayMovies();
    getOnPopularMovies();
  }
    getOnDisplayMovies() async{
      var url = Uri.https(_baseUrl, '3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',

      });
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    }
    getOnPopularMovies() async{
      var url = Uri.https(_baseUrl, '3/movie/popular', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1',

      });
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      final popularResponse = PopularResponse.fromJson(response.body);

      popularMovies = [...popularMovies, ...popularResponse.results];
      print(popularMovies[0]);
      notifyListeners();
    }
}
