import 'package:flutter/material.dart';
import 'package:movlib/view/account/account_view.dart';
import 'package:movlib/view/configuration/configuration_view.dart';
import 'package:movlib/view/details/details_view.dart';
import 'package:movlib/view/details/details_view_model.dart';
import 'package:movlib/view/home/home_view_model.dart';
import 'package:movlib/view/review/review_view_model.dart';
import 'package:movlib/view/search/search_view.dart';
import 'package:movlib/view/search/search_view_model.dart';
import 'package:movlib/view/splash/splash_view.dart';
import 'package:provider/provider.dart';

import 'consts/colors.dart';
import 'view/home/home_view.dart';
import 'view/login/login_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => ReviewViewModel()),
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovLib',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: KDark,
        primaryColor: KDarker,
        accentColor: KWhiter,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Gilroy',
              bodyColor: KWhiter,
              displayColor: KWhiter,
              decorationColor: KWhiter,
            ),
      ),
      routes: {
        SplashView.route: (context) => SplashView(),
        HomeView.route: (context) => HomeView(),
        DetailsView.route: (context) => DetailsView(),
        LoginView.route: (context) => LoginView(),
        ConfigurationView.route: (context) => ConfigurationView(),
        SearchView.route: (context) => SearchView(),
        AccountView.route: (context) => AccountView(),
      },
      initialRoute: SplashView.route,
    );
  }
}
