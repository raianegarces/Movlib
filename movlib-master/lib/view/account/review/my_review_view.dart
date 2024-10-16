import 'package:flutter/material.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/model/app_user.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/account/review/my_review_view_model.dart';
import 'package:movlib/view/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MyReviewView extends StatelessWidget {
  MyReviewViewModel reviewVM = MyReviewViewModel();

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<HomeViewModel>(context).currentUser.id;
    reviewVM.userId = userId;

    return FutureBuilder(
      future: reviewVM.getUserReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (reviewVM.userReviews == null || reviewVM.userReviews.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Você ainda não possui nenhuma avaliação'),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: reviewVM.userReviews.length,
              itemBuilder: (context, index) {
                return UserReviewCard(reviewVM.userReviews[index]);
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class UserReviewCard extends StatelessWidget {
  const UserReviewCard(this.movieReview);
  final MovieReview movieReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      '${TmdbConsts.imagePath}${movieReview.movieDetail.posterPath}',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: double.infinity,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Text(movieReview.movieDetail.title,
                        style: TextStyle(
                            color: KDark,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Text(
                      movieReview.review.review,
                      style: TextStyle(
                        color: KDark,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: KGold,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(movieReview.review.rating.toString(),
                          style: TextStyle(
                            color: KDark,
                            fontSize: 17,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
