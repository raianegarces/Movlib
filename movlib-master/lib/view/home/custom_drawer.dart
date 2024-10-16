import 'package:flutter/material.dart';
import 'package:movlib/view/home/custom_drawer_view_model.dart';
import '../../consts/colors.dart';
import 'home_view_model.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool showMovies = true;
  CustomDrawerViewModel _customDrawerVM = CustomDrawerViewModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) => SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: KDark,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          color: KDarker,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: size.height * 0.08,
                                backgroundImage: NetworkImage(
                                    homeViewModel.currentUser.imageUrl),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(homeViewModel.currentUser.displayName),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child:
                                          Text(homeViewModel.currentUser.tag),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      '${homeViewModel.currentUser.followers ?? 0} Seguidores'),
                                  Text(
                                      '${homeViewModel.currentUser.following ?? 0} Seguindo'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            OptionsItem(
                              icon: Icons.account_circle,
                              text: 'Perfil',
                              onTap: () =>
                                  _customDrawerVM.onProfilePressed(context),
                            ),
                            OptionsItem(
                              icon: Icons.star,
                              text: 'Favoritos',
                              onTap: () =>
                                  _customDrawerVM.onFavoritePressed(context),
                            ),
                            OptionsItem(
                              icon: Icons.rate_review,
                              text: 'Avaliações',
                              onTap: () =>
                                  _customDrawerVM.onReviewPressed(context),
                            ),
                            OptionsItem(
                              icon: Icons.settings,
                              text: 'Configurações',
                              onTap: () =>
                                  _customDrawerVM.onConfigPressed(context),
                            ),
                            Spacer(flex: 6),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/logo_no_background.png',
                                  height: 64,
                                ),
                                SizedBox(width: 16),
                                Text('MovLib',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24)),
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionsItem extends StatelessWidget {
  OptionsItem({this.onTap, this.text, this.icon});

  final Function onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 8),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
