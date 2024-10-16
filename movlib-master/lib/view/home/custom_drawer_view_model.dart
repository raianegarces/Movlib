import 'package:flutter/material.dart';
import 'package:movlib/view/account/account_view.dart';
import 'package:movlib/view/configuration/configuration_view.dart';

class CustomDrawerViewModel {
  void onProfilePressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(initialIndex: 0),
      ),
    );
  }

  void onFavoritePressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(initialIndex: 1),
      ),
    );
  }

  void onReviewPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountView(initialIndex: 2),
      ),
    );
  }

  void onConfigPressed(BuildContext context) {
    Navigator.pushNamed(context, ConfigurationView.route);
  }
}
