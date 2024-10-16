import 'package:flutter/material.dart';
import 'package:movlib/model/movie.dart';
import 'package:movlib/model/movie_details.dart';
import 'package:movlib/model/review.dart';
import 'package:movlib/service/review_api.dart';
import 'package:movlib/view/details/details_view.dart';
import 'package:movlib/view/home/home_view_model.dart';
import 'package:provider/provider.dart';

/// Classe model do Provider
///
/// Para utilizar algum widget que utiliza uma variável do model ->
/// Consumer<ReviewViewModel>(
///   builder: (context, reviewViewModel, child) =>
///   Widget(
///      top: homeViewModel.variável
///                     ),
///                    ),
///
/// Para utilizar alguma função do model ->
/// context.read<ReviewViewModel>().funçãoDoModel();

class ReviewViewModel extends ChangeNotifier {
  String review;
  double rating = 3;
  MovieDetail movie;

  void setMovie(MovieDetail movie) {
    this.movie = movie;
    notifyListeners();
  }

  void setRating(double rating) {
    this.rating = rating;
    notifyListeners();
  }

  void setReview(String review) {
    this.review = review;
    notifyListeners();
  }

  Future<void> onSendButtonPressed(BuildContext context) async {
    Review _review = Review(
        movieId: this.movie.id.toString(),
        review: this.review,
        rating: this.rating,
        user: context.read<HomeViewModel>().currentUser);
    print('review json: ${_review.toJson()}');

    bool success = await ReviewApi.addReview(_review);

    if (success) {
      showDialog(
        context: context,
        child: SimpleDialog(
          title: Text(
              'Avaliação enviada com sucesso!'),
          children: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, child: Text('Ok')),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        child: SimpleDialog(
          title: Text(
              'Ocorreu um erro ao enviar sua avaliação. Por favor tente novamente!'),
          children: [
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('Ok')),
          ],
        ),
      );
    }
  }
}
