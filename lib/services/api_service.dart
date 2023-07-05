import 'package:dio/dio.dart';
import '../models/movie.dart';
import 'api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // Construction URL
    // ignore: no_leading_underscores_for_local_identifiers
    String _url = api.baseURL + path;

    //Construction du paramètres
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };

    //Si pas null on ajoute le contenu à query
    if (params != null) {
      query.addAll(params);
    }

    final response = await dio.get(_url, queryParameters: query);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopulaMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }

      return movies;
    } else {
      throw response;
    }
  }
}
