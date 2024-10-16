import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movlib/consts/colors.dart';

class UserReviewCard extends StatelessWidget {
  UserReviewCard({this.imageUrl, this.userName, this.review, this.rating});

  final String imageUrl, userName, review;
  final double rating;

  final TextStyle userNameTS = TextStyle(color: KDarker, fontSize: 16, fontWeight: FontWeight.bold);
  final TextStyle reviewTS = TextStyle(color: KDarker, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisSize: MainAxisSize.max,
            children: [
              //User info
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                      radius: size.height * 0.04,
                      backgroundColor: KDark,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        userName,
                        style: userNameTS,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: size.width*0.02),

              // Review Rating
              Expanded(
                child: RatingBar(
                  initialRating: rating,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: KGold,
                  ),
                  glow: false,
                  ignoreGestures: true,
                  onRatingUpdate: (double value) {},
                  itemSize: size.width*0.06,
                ),
              ),
            ],
          ),
          Divider(
            color: KDarker,
            indent: 8,
            endIndent: 8,
            height: size.height*0.03,
          ),

          // Review
          Text(review, style: reviewTS,),
        ],
      ),
    );
  }
}