import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movlib/model/movie.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/components/home_screen_movie_card.dart';
import 'package:http/http.dart' as http;

class SearchViewModel extends ChangeNotifier {
  Timer _timer;
  int page = 1;
  bool hasError = false;
  final scrollController = ScrollController();
  List<HomeScreenMovieCard> movieCards = [];
  TmdbApi tmdbApi = TmdbApi(new http.Client());

  void onBackButtonPressed(BuildContext context){
    Navigator.pop(context);
  }

  void onSearchChanged(String query) {
    if (_timer?.isActive ?? false) _timer.cancel();
    _timer = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty)
        getMovieQuery(query);
      else {
        movieCards.clear();
      }
    });
  }

  Future<void> getMovieQuery(String query) async {
    this.page = 1;
    List<Movie> movies = await tmdbApi.fetchMovieQuery(page, query);
    if(movies == null) {
      this.hasError = true;
      return;
    }
    else this.hasError = false;

    movieCards.clear();
    _movieToMovieContainer(movies);
    notifyListeners();
  }

  void _movieToMovieContainer(List<Movie> movies) {
    movies.forEach((movie) {
      movieCards.add(HomeScreenMovieCard(
        title: movie.title,
        movieId: movie.id,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage,
        overview: movie.overview,
      ));
    });
  }

}