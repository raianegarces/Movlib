import 'package:flutter/material.dart';
import 'package:movlib/model/app_user.dart';
import 'package:movlib/service/cache_manager.dart';
import 'package:movlib/service/user_api.dart';
import 'package:movlib/view/home/home_view.dart';
import 'package:movlib/view/home/home_view_model.dart';
import 'package:movlib/view/login/login_view.dart';
import 'package:provider/provider.dart';

class SplashViewModel {
  static Future<void> loadData(BuildContext context) async{
    String userId = await CacheManager.getUserId();
    print('userId: $userId');

    if(userId == null) {
      Navigator.popAndPushNamed(context, LoginView.route);
    } else {
      AppUser appUser = await UserApi.getUser(userId);
      Provider.of<HomeViewModel>(context, listen: false).setCurrentUser(appUser);
      Navigator.popAndPushNamed(context, HomeView.route);
    }
  }
}