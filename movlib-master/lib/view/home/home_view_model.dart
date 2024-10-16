import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movlib/model/movie.dart';
import 'package:movlib/service/tmdb_api.dart';
import 'package:movlib/view/components/home_screen_movie_card.dart';
import 'package:movlib/view/search/search_view.dart';
import '../../model/app_user.dart';
import 'package:http/http.dart' as http;

/// Classe model do Provider
///
/// Para utilizar algum widget que utiliza uma variável do model ->
/// Consumer<HomeViewModel>(
///   builder: (context, homeViewModel, child) =>
///   Widget(
///      top: homeViewModel.variável
///                     ),
///                    ),
///
/// Para utilizar alguma função do model ->
/// Provider.of<HomeViewModel>(context, listen: false).funçãoDoModel();
///


class HomeViewModel extends ChangeNotifier {
  AppUser currentUser;
  bool isLoading = true;
  TabController tabController;
  int page = 1;
  final scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey2 =
  GlobalKey<RefreshIndicatorState>();
  List<HomeScreenMovieCard> popMovieCards = List();
  List<HomeScreenMovieCard> upMovieCards = List();
  TmdbApi tmdbApi = TmdbApi(new http.Client());

  void onSearchButtonPressed(BuildContext context){
    Navigator.pushNamed(context, SearchView.route);
  }

  void initCalls(TabController pageTabController) {
    tabController = pageTabController;
    tabController.addListener(() {
      refresh();
    });

    getMovies();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getMovies();
      }
    });
  }
  void setIsLoading(bool newValue){
    isLoading = newValue;
    notifyListeners();
  }

  Future<Null> refresh() async {
    page = 1;
    popMovieCards.clear();
    upMovieCards.clear();
    await getMovies();
    notifyListeners();
  }

  Future<void> getMovies() async {
    var response;
    switch (tabController.index) {
      case 0:
        {
          response = await tmdbApi.fetchPopularMovies(page);
            response.forEach((e) {
              popMovieCards.add(HomeScreenMovieCard(
                title: e.title,
                voteAverage: e.voteAverage,
                overview: e.overview,
                posterPath: e.posterPath,
                movieId: e.id,
              ));
            });
          notifyListeners();
          return popMovieCards;
        }
        break;

      case 1:
        {
          response = await tmdbApi.fetchUpcomingMovies(page);
            response.forEach((e) {
              upMovieCards.add(HomeScreenMovieCard(
                title: e.title,
                voteAverage: e.voteAverage,
                overview: e.overview,
                posterPath: e.posterPath,
                movieId: e.id,
              ));
            });
          notifyListeners();
          return upMovieCards;
        }
        break;

      default:
        {
          print('Error - tabControler index -> ${tabController.index}');
          notifyListeners();
        }
        break;
    }
  }

  void setCurrentUser(AppUser user){
    this.currentUser = user;
    notifyListeners();
  }
}
