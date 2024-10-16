import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movlib/model/app_user.dart';
import 'package:movlib/service/cache_manager.dart';
import '../home/home_view.dart';
import '../home/home_view_model.dart';
import '../../service/user_api.dart';
import 'package:provider/provider.dart';

class LoginViewModel {
  static loginWithGoogle(BuildContext context) async {
    showDialog(context: context, child: Center(child: CircularProgressIndicator()));

    AppUser appUser;
    User _user = await UserApi.signInWithGoogle();

    appUser = await UserApi.getUser(_user.uid);

    if (appUser == null) {
      appUser = AppUser.fromFirebaseUser(_user);
      bool userAdded = await UserApi.addUser(appUser);

      if (!userAdded) {
        print('Failed to add user');
        return;
      }
    }

    CacheManager.setUserId(appUser.id);
    Provider.of<HomeViewModel>(context, listen: false).setCurrentUser(appUser);
    Navigator.pushNamedAndRemoveUntil(context, HomeView.route, (route) => false);
  }
}
