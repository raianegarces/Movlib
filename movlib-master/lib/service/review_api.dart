import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movlib/model/app_user.dart';
import 'package:movlib/model/review.dart';

class ReviewApi {
  static const _reviewCollection = 'reviews';

  static Future<bool> addReview(Review review) async {
    final FirebaseApp _initialization = await Firebase.initializeApp();
    CollectionReference reviewCollectionRef =
        FirebaseFirestore.instance.collection(_reviewCollection);

    await reviewCollectionRef.add(review.toJson()).then((value) {
      print('Review added');
    }).catchError((error) {
      print("Failed to add user: $error");
      return false;
    });

    return true;
  }

  static Future<List<Review>> getReviews(String movieId) async {
    List<Review> reviews = [];

    final FirebaseApp _initialization = await Firebase.initializeApp();
    CollectionReference reviewCollectionRef =
        FirebaseFirestore.instance.collection(_reviewCollection);

    QuerySnapshot reviewQuery =
        await reviewCollectionRef.where('movieId', isEqualTo: movieId).get();

    if (reviewQuery.size == 0) {
      print('No review found for movie: $movieId');
    } else {
      print('${reviewQuery.size} reviews found');
      reviewQuery.docs.forEach((element) {
        reviews.add(Review.fromJson(element.data()));
      });
      print('reviews.length: ${reviews.length}');
    }

    return reviews;
  }

  static Future<List<Review>> getUserReviews(String userId) async {
    List<Review> reviews = [];

    final FirebaseApp _initialization = await Firebase.initializeApp();
    CollectionReference reviewCollectionRef =
        FirebaseFirestore.instance.collection(_reviewCollection);

    QuerySnapshot reviewQuery =
        await reviewCollectionRef.where('user.id', isEqualTo: userId).get();

    if (reviewQuery.size == 0) {
      print('No reviews found for user: $userId');
    } else {
      print('${reviewQuery.size} reviews found');
      reviewQuery.docs.forEach((element) {
        reviews.add(Review.fromJson(element.data()));
      });
      print('reviews.length: ${reviews.length}');
    }

    return reviews;
  }
}
