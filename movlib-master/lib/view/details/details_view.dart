import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/details/details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  static const route = 'DetailsView';

  DetailsView({
    @required this.id,
    @required this.title,
  });

  final int id;
  final String title;

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  DetailsViewModel detailsViewModel;

  @override
  void initState() {
    detailsViewModel = DetailsViewModel(movieId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: detailsViewModel.initCalls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DefaultTabController(
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
                        /*actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(icon: liked ? Icon(Icons.favorite) : Icon(Icons.favorite_border), onPressed: () {
                        detailsViewModel.setIsLiked(!detailsViewModel.isLiked);
                        setState(() {
                          liked = !liked;
                        });
                      },),
                    ),
                  ],*/
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(widget.title),
                          background: detailsViewModel.movie == null
                              ? SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Stack(
                                  children: <Widget>[
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            child: Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: PhotoView(
                                                  imageProvider: NetworkImage(
                                                      '${TmdbConsts.imagePathOriginal}${detailsViewModel.movie.posterPath}'),
                                                  backgroundDecoration:
                                                      BoxDecoration(
                                                          color: Colors
                                                              .transparent),
                                                ),
                                              ),
                                            ));
                                      },
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image:
                                            '${TmdbConsts.imagePathOriginal}${detailsViewModel.movie.posterPath}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Overview
                          Text(
                            detailsViewModel.movie.overview,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          // Release Date, Runtime and Vote Average
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${detailsViewModel.movie.releaseDate.day}/${detailsViewModel.movie.releaseDate.month.toString().length == 2 ? detailsViewModel.movie.releaseDate.month : '0${detailsViewModel.movie.releaseDate.month}'}/${detailsViewModel.movie.releaseDate.year}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${Duration(minutes: detailsViewModel.movie.runtime).inHours} h ${detailsViewModel.movie.runtime - (Duration(minutes: detailsViewModel.movie.runtime).inHours * 60)} m',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: KGold,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    '${detailsViewModel.movie.voteAverage}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          // Genres
                          Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      detailsViewModel.movie.genres.length,
                                  itemBuilder: (_context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: KDark,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            width: 1,
                                            color: KWhite,
                                          )),
                                      child: Center(
                                          child: Text(
                                        detailsViewModel
                                            .movie.genres[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )),
                                    );
                                  })),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                          // Avaliações dos Usuários
                          InkWell(
                            onTap: () => detailsViewModel.usersReviewsOnPressed(context, detailsViewModel.movie),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Avaliações dos usuários', style: TextStyle(fontSize: 18),),
                                    Icon(Icons.arrow_forward, size: 24,),
                                  ],
                                ),
                                Divider(height: 4, color: KWhiter,),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                          // Trailer
                          Text(
                            'Trailer',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          detailsViewModel.ytController == null
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Não foi possível encontrar o trailer deste filme :('),
                                  ),
                                )
                              : YoutubePlayer(
                                  controller: detailsViewModel.ytController,
                                  width: double.infinity,
                                  bottomActions: <Widget>[],
                                  topActions: [
                                    PopupMenuButton<void>(
                                      onSelected: (_) async {
                                        final url =
                                            'https://www.youtube.com/watch?v=${detailsViewModel.ytController.initialVideoId}';
                                        bool _canLaunch = await canLaunch(url);
                                        if (_canLaunch) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<void>>[
                                        const PopupMenuItem<void>(
                                          value: 0,
                                          child: Text('Abrir no YouTube'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                          // Actors
                          Text(
                            'Atores',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          detailsViewModel.actors.length == 0
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Não foi possível encontrar os atores deste filme :('),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          detailsViewModel.actors.length > 7
                                              ? 7
                                              : detailsViewModel.actors.length,
                                      itemBuilder: (_context, index) {
                                        return Container(
                                          margin: EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                child: Stack(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                    FadeInImage.memoryNetwork(
                                                      placeholder:
                                                          kTransparentImage,
                                                      image:
                                                          '${TmdbConsts.imagePath}${detailsViewModel.actors[index].profilePath}',
                                                      fit: BoxFit.fitWidth,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.32,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Text(
                                                  detailsViewModel
                                                      .actors[index].name,
                                                  style: TextStyle(
                                                      color: KWhite,
                                                      fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),

                          // Similar Movies
                          Text(
                            'Filmes Relacionados',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          detailsViewModel.similarMovies.length == 0
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Não foi possível encontrar filmes relacionados a este :('),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: detailsViewModel
                                                  .similarMovies.length >
                                              7
                                          ? 7
                                          : detailsViewModel
                                              .similarMovies.length,
                                      itemBuilder: (_context, index) {
                                        return InkWell(
                                          onTap: () {
                                            detailsViewModel
                                                .similarMovieOnPressed(
                                                    context,
                                                    detailsViewModel
                                                        .similarMovies[index]);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(8),
                                            child: Column(
                                              //mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                      FadeInImage.memoryNetwork(
                                                        placeholder:
                                                            kTransparentImage,
                                                        image:
                                                            '${TmdbConsts.imagePath}${detailsViewModel.similarMovies[index].posterPath}',
                                                        fit: BoxFit.fitWidth,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.32,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Text(
                                                    detailsViewModel
                                                        .similarMovies[index]
                                                        .title,
                                                    style: TextStyle(
                                                        color: KWhite,
                                                        fontSize: 18),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.rate_review_outlined,
            color: KDarker,
          ),
          backgroundColor: KWhite,
          onPressed: () => detailsViewModel.fabOnPressed(context),
        ),
      );
  }
}
