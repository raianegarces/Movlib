import 'package:flutter/material.dart';
import 'package:movlib/model/review.dart';
import 'package:movlib/service/review_api.dart';

class UsersReviewsViewModel {
  UsersReviewsViewModel({@required this.movieId});

  String movieId;
  List<Review> reviews;

  Future<void> getReviews() async{
    reviews = await ReviewApi.getReviews(movieId);
    return;
  }

}