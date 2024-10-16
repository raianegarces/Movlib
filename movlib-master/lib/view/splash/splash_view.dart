import 'package:flutter/material.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/view/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  static const route = 'Splash_view';

  @override
  Widget build(BuildContext context) {
    SplashViewModel.loadData(context);
    return Scaffold(
      backgroundColor: KDarker,
      body: Center(
        child: Image.asset('assets/launcher/logo_launcher.png', height: MediaQuery.of(context).size.height*0.5),
      ),
    );
  }
}
