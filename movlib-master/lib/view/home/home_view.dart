import 'package:flutter/material.dart';
import 'package:movlib/view/components/home_screen_movie_card.dart';
import 'package:movlib/view/home/custom_drawer.dart';
import 'home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const route = 'home_view';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var viewModel;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<HomeViewModel>().initCalls(_tabController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text('MovLib'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => homeViewModel.onSearchButtonPressed(context),
                padding: const EdgeInsets.only(right: 16),
              ),
            ],
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Populares',
                ),
                Tab(
                  text: 'Em Breve',
                ),
              ],
              controller: homeViewModel.tabController,
            ),
          ),
          body: TabBarView(
            controller: homeViewModel.tabController,
            children: [
              // Popular Movies
              homeViewModel.popMovieCards.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      key: homeViewModel.refreshIndicatorKey,
                      onRefresh: homeViewModel.refresh,
                      child: ListView.builder(
                        controller: homeViewModel.scrollController,
                        itemCount: homeViewModel.popMovieCards.length + 1,
                        itemBuilder: (_context, index) {
                          if (index < homeViewModel.popMovieCards.length) {
                            return homeViewModel.popMovieCards[index];
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(32),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),

              // Upcoming Movies
              homeViewModel.upMovieCards.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      key: homeViewModel.refreshIndicatorKey2,
                      onRefresh: homeViewModel.refresh,
                      child: ListView.builder(
                        controller: homeViewModel.scrollController,
                        itemCount: homeViewModel.upMovieCards.length + 1,
                        itemBuilder: (_context, index) {
                          if (index < homeViewModel.upMovieCards.length) {
                            return homeViewModel.upMovieCards[index];
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(32),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
