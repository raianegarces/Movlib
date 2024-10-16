import 'package:flutter/material.dart';
import 'login_view_model.dart';
import '../../consts/colors.dart';

class LoginView extends StatelessWidget {
  static const route = 'login_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KDarker,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 3,),
            Image.asset('assets/launcher/logo_launcher.png', height: MediaQuery.of(context).size.height*0.5),
            Spacer(flex: 5,),
            Text('Entre com uma das opções abaixo', style: TextStyle(fontSize: 18),),
            Spacer(),
            GestureDetector(
              onTap: () async {
                await LoginViewModel.loginWithGoogle(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: KWhite,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Image.asset('assets/images/google_logo.png', width: 32,),
              ),
            ),
            Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}
