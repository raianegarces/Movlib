import 'dart:convert';
import '../model/actor.dart';
import '../model/movie.dart';
import 'package:http/http.dart' as http;
import '../model/movie_details.dart';

class TmdbApi {
  TmdbApi(this.httpClient);

  http.Client httpClient;

  Future<List<Movie>> fetchPopularMovies(int page) async {
    List<Movie> movies;
    var body;
    try {
      final response = await httpClient.get('${TmdbConsts.popularMoviesUrl}$page');

      if (response.statusCode == 200) {
        body = jsonDecode(response.body)['results'];
        movies = List<Movie>.from(body.map((movie) => Movie.fromJson(movie)))
            .toList();
      }
    } catch (e) {
      print('error fetching popular movies: $e');
    }
    return movies;
  }

  Future<List<Movie>> fetchMovieQuery(int page, String query) async {
    List<Movie> movies;
    var body;
    try {
      final response = await httpClient.get(TmdbConsts.movieQueryUrl(page, query));

      if (response.statusCode == 200) {
        body = jsonDecode(response.body)['results'];
        movies = List<Movie>.from(body.map((movie) => Movie.fromJson(movie)))
            .toList();
      }
    } catch (e) {
      print('error fetching movie query: $e');
    }
    return movies;
  }

  Future<List<Movie>> fetchUpcomingMovies(int page) async {
    List<Movie> movies;
    var body;
    try {
      final response = await httpClient.get('${TmdbConsts.upcomingMoviesUrl}$page');

      if (response.statusCode == 200) {
        body = jsonDecode(response.body)['results'];
        movies = List<Movie>.from(body.map((movie) => Movie.fromJson(movie)))
            .toList();
      }
    } catch (e) {
      print('error fetching upcoming movies: $e');
    }
    return movies;
  }

  Future<List<Movie>> fetchSimilarMovies(int id) async {
    List<Movie> movies;
    var body;
    try {
      final response = await httpClient.get('${TmdbConsts.similarMoviesUrl(id)}1');

      if (response.statusCode == 200) {
        body = jsonDecode(response.body)['results'];
        movies = List<Movie>.from(body.map((movie) => Movie.fromJson(movie)))
            .toList();
      }
    } catch (e) {
      print('error fetching similar movies: $e');
    }
    return movies;
  }

  Future<MovieDetail> fetchMovieDetails(int id) async {
    var body;
    MovieDetail movieDetail;

    try {
      final response = await httpClient.get('${TmdbConsts.movieDetailsUrl(id)}');

      if (response.statusCode == 200) {
        body = jsonDecode(response.body);
        movieDetail = MovieDetail.fromJson(body);
      }
    } catch (e) {
      print('error fetching movie details: $e');
    }

    return movieDetail;
  }

  Future<List<Actor>> fetchActors(int id) async {
    var body;
    List<Actor> actors;

    try {
      final response = await httpClient.get('${TmdbConsts.movieActorsUrl(id)}');

      if (response.statusCode == 200) {
        body = jsonDecode(response.body)['cast'];
        actors = List<Actor>.from(body.map((actor) => Actor.fromJson(actor)))
            .toList();
      }
    } catch (e) {
      print('error fetching movie actors: $e');
    }

    return actors;
  }

  Future<String> fetchTrailerKey(int id) async {
    var body;
    String key;

    try {
      var response = await httpClient.get('${TmdbConsts.movieTrailerUrl(id)}');

      if (response.statusCode == 200) {
        body = jsonDecode(response.body)['results'];
        key = body[0]['key'];
      }
    } catch (e) {
      print('error fetching movie movie trailer key: $e');
    }

    return key;
  }
}

class TmdbConsts {
  static const key = '92617104f2646d905240d1f828861df6';
  static const apiKey = 'api_key=$key';

  static const pt_br = 'pt-BR';
  static const language = 'language=$pt_br';

  static const imagePath = 'https://image.tmdb.org/t/p/w500/';
  static const imagePathOriginal = 'https://image.tmdb.org/t/p/original';
  static const baseUrl = 'https://api.themoviedb.org/3/';
  static const page = '&page=';

  static const popularMovies = 'movie/popular';
  static const popularMoviesUrl =
      '$baseUrl$popularMovies?$apiKey&$language$page';

  static const upcomingMovies = 'movie/upcoming';
  static const upcomingMoviesUrl =
      '$baseUrl$upcomingMovies?$apiKey&$language$page';

  static String similarMoviesUrl(int id) =>
      '${baseUrl}movie/$id/similar?$apiKey&$language$page';

  static String movieDetailsUrl(int id) =>
      '${baseUrl}movie/$id?$apiKey&$language';

  static String movieActorsUrl(int id) =>
      '${baseUrl}movie/$id/credits?$apiKey&$language';

  static String movieTrailerUrl(int id) =>
      '${baseUrl}movie/$id/videos?$apiKey&$language';

  static String movieQueryUrl(int page, String query) {
    String _query = query.replaceAll(' ', '%20');

    return '${baseUrl}search/movie?$apiKey&$language&query=$_query&page=$page';
  }
}
