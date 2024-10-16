import 'package:movlib/model/movie_details.dart';
import 'package:movlib/model/review.dart';
import 'package:movlib/service/review_api.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:http/http.dart' as http;

class MyReviewViewModel {
  String userId;
  List<MovieReview> userReviews = [];
  TmdbApi tmdbApi = TmdbApi(new http.Client());

  Future<List<MovieReview>> getUserReviews() async {
    List<Review> reviews = await ReviewApi.getUserReviews(userId);

    for (int i = 0; i < reviews.length; i++) {
      MovieDetail movieDetail =
          await tmdbApi.fetchMovieDetails(int.parse(reviews[i].movieId));

      userReviews
          .add(MovieReview(review: reviews[i], movieDetail: movieDetail));
    }

    return userReviews;
  }
}

class MovieReview {
  MovieReview({this.movieDetail, this.review});

  MovieDetail movieDetail;
  Review review;
}
