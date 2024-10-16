import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/view/components/user_review_card.dart';
import 'package:movlib/view/users_reviews/users_reviews_view_model.dart';

class UsersReviewsView extends StatefulWidget {
  UsersReviewsView({
    @required this.id,
    @required this.title,
  });

  final int id;
  final String title;

  @override
  _UsersReviewsViewState createState() => _UsersReviewsViewState();
}

class _UsersReviewsViewState extends State<UsersReviewsView> {
  UsersReviewsViewModel usersReviewsViewModel;

  @override
  void initState() {
    usersReviewsViewModel = UsersReviewsViewModel(movieId: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações - ${widget.title}'),
      ),
      body: FutureBuilder(
        future: usersReviewsViewModel.getReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (usersReviewsViewModel.reviews == null || usersReviewsViewModel.reviews.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Nossos usuários ainda não fizeram nenhuma avaliação para este filme :('),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: usersReviewsViewModel.reviews.length,
                itemBuilder: (context, index) {
                  return UserReviewCard(
                    imageUrl: usersReviewsViewModel.reviews[index].user.imageUrl,
                    rating: usersReviewsViewModel.reviews[index].rating,
                    review: usersReviewsViewModel.reviews[index].review,
                    userName: usersReviewsViewModel.reviews[index].user.tag,
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}