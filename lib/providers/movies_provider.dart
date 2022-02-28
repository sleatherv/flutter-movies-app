
import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{
  MoviesProvider(){
    print('MoviesProvider initialized');
    this.getOnDiplayMovies();
  }
    getOnDiplayMovies() async{
      print('getOnDisplayMovies');
    }
}
