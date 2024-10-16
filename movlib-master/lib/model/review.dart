import 'dart:convert';

import 'package:movlib/model/app_user.dart';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  Review({
    this.movieId,
    this.rating,
    this.review,
    this.user,
  });

  String movieId;
  double rating;
  String review;
  AppUser user;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    movieId: json["movieId"] == null ? null : json["movieId"],
    rating: json["rating"] == null ? null : json["rating"],
    review: json["review"] == null ? null : json["review"],
    user: json["user"] == null ? null : AppUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "movieId": movieId == null ? null : movieId,
    "rating": rating == null ? null : rating,
    "review": review == null ? null : review,
    "user": user == null ? null : user.toReviewJson(),
  };
}
