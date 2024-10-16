import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/home/home_view_model.dart';
import 'package:movlib/view/review/review_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewViewModel>(
      builder: (context, reviewViewModel, child) => Scaffold(
        body: DefaultTabController(
          length: 1,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 400.0,
                    floating: false,
                    pinned: true,
                    snap: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(reviewViewModel.movie.title),
                      background: Stack(
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                '${TmdbConsts.imagePathOriginal}${reviewViewModel.movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) => reviewViewModel.setReview(value),
                        decoration: InputDecoration(
                            hintText: 'Escreva sua avaliação...',
                            hintStyle: TextStyle(color: KWhiter),
                            contentPadding: const EdgeInsets.all(24),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        style: TextStyle(color: KWhiter),
                        minLines: 5,
                        maxLines: 10,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar(
                            initialRating: 3,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: KGold,
                            ),
                            onRatingUpdate: (rating) {
                              reviewViewModel.setRating(rating);
                              print('rating: ${reviewViewModel.rating}');
                            },
                            glow: false,
                          ),
                          InkWell(
                            onTap: () async {
                              await reviewViewModel.onSendButtonPressed(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: KWhiter,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: Text(
                                  'Enviar',
                                  style: TextStyle(
                                      color: KDarker,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
