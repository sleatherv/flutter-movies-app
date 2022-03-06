
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';


class MoviesProvider extends ChangeNotifier{

  final String _apiKey = 'fe3645cf9bed3ff625f6344c89102ffa';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    // print('MoviesProvider initialized');
    getOnDisplayMovies();
    getOnPopularMovies();

  }
    Future<String> _getJsonData(String endPoint, [int page = 1]) async{
      var url = Uri.https(_baseUrl, endPoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page',

      });
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);

      return response.body;
    }

    getOnDisplayMovies() async{
      final jsonData = await _getJsonData('3/movie/now_playing');

      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    }
    getOnPopularMovies() async{
      _popularPage ++;
      final jsonData = await _getJsonData('3/movie/popular', _popularPage);
      final popularResponse = PopularResponse.fromJson(jsonData);

      popularMovies = [...popularMovies, ...popularResponse.results];
      notifyListeners();
    }

  Future<List<Cast>>  getMovieCast(int movieId) async{

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!; //Check if cast object exists in Map

      final jsonData = await _getJsonData('3/movie/$movieId/credits');
      final creditsResponse = CreditsResponse.fromJson(jsonData);

      moviesCast[movieId] = creditsResponse.cast;

      return creditsResponse.cast;
    }
}
