import 'package:flutter/material.dart';
import 'package:movlib/model/actor.dart';
import 'package:movlib/model/movie.dart';
import 'package:movlib/model/movie_details.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/details/details_view.dart';
import 'package:movlib/view/review/review_view.dart';
import 'package:movlib/view/review/review_view_model.dart';
import 'package:movlib/view/users_reviews/users_reviews_view.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class DetailsViewModel {
  DetailsViewModel({this.movieId});

  MovieDetail movie;
  YoutubePlayerController ytController;
  List<Actor> actors = List<Actor>();
  List<Movie> similarMovies = List<Movie>();
  int movieId;
  bool isLoading = true;
  bool isLiked = false;
  TmdbApi tmdbApi = TmdbApi(new http.Client());

  Future<void> initCalls() async {
    await getDetail();
    await getTrailer();
    await getActors();
    await getSimilarMovies();
    return;
  }

  void setIsLiked(bool isLiked) {
    this.isLiked = isLiked;
  }

  void setMovieId(int newId) {
    movieId = newId;
  }

  Future<void> getDetail() async {
    var response;
    response = await tmdbApi.fetchMovieDetails(movieId);
    movie = response;
  }

  Future<void> getTrailer() async {
    String initialVideoId = await tmdbApi.fetchTrailerKey(movieId);

    ytController = YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Future<void> getActors() async {
    var response;
    response = await tmdbApi.fetchActors(movieId);
    actors = response;
  }

  Future<void> getSimilarMovies() async {
    var response;
    response = await tmdbApi.fetchSimilarMovies(movieId);
    similarMovies = response;
  }

  void fabOnPressed(BuildContext context) {
    Provider.of<ReviewViewModel>(context, listen: false).setMovie(movie);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReviewView()));
  }

  void similarMovieOnPressed(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsView(
          id: movie.id,
          title: movie.title,
        ),
      ),
    );
  }

  void usersReviewsOnPressed(BuildContext context, MovieDetail movie){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsersReviewsView(
          id: movie.id,
          title: movie.title,
        ),
      ),
    );
  }
}
