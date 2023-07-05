// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notnetflix/services/api_service.dart';
import '../models/movie.dart';

class DataRepository with ChangeNotifier {
  // Une instance d'API pour faire les appels
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1; // Pour indiquer le numero de pages

  //getters
  List<Movie> get popularMovieList => _popularMovieList;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPopulaMovies(pageNumber: _popularMoviePageIndex);
      // On ajoute le contenu dans la liste
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow; // relance de l'erreur !
    }
  }
}
