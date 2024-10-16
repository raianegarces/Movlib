import 'package:flutter/material.dart';
import 'package:movlib/view/account/fav/fav_view.dart';
import 'package:movlib/view/account/profile/profile_view.dart';
import 'package:movlib/view/account/review/my_review_view.dart';

class AccountView extends StatefulWidget {
  static const route = 'account_view';
  const AccountView({this.initialIndex = 0});

  final int initialIndex;

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(widget.initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Conta'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Perfil',
              ),
              Tab(
                text: 'Favoritos',
              ),
              Tab(
                text: 'Avaliações',
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ProfileView(),
            FavView(),
            MyReviewView(),
          ],
        ),
      ),
    );
  }
}
