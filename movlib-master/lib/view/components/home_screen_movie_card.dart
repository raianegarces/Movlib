import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/details/details_view.dart';
import 'package:movlib/view/details/details_view_model.dart';
import 'package:provider/provider.dart';
import '../../consts/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreenMovieCard extends StatelessWidget {
  const HomeScreenMovieCard({
    @required this.title,
    @required this.voteAverage,
    @required this.overview,
    @required this.posterPath,
    @required this.movieId,
  });

  final String title;
  final String voteAverage;
  final String overview;
  final String posterPath;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsView(
                  id: movieId,
                  title: title,
                )));
      },
      child: Container(
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
                    image: '${TmdbConsts.imagePath}$posterPath',
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
                      child: Text(title,
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
                        overview,
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
                        Text(voteAverage,
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
      ),
    );
  }
}
