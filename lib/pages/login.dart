import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fb_login_auth/blocs/auth_bloc.dart';
import 'package:google_fb_login_auth/pages/home.dart';
import 'package:google_fb_login_auth/pages/home2.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription<User> googleloginStateSubscription;
  StreamSubscription<User> facebookloginStateSubscription;

  @override
  void initState() {
    var authBloc1 = Provider.of<AuthBloc1>(context, listen: false);
    var authBloc2 = Provider.of<AuthBloc2>(context, listen: false);
    googleloginStateSubscription = authBloc1.currentUser.listen((firebaseUser) {
      if (firebaseUser != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      }
    });
    facebookloginStateSubscription =
        authBloc2.currentUser.listen((firebaseUser) {
      if (firebaseUser != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage2(),
        ));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    googleloginStateSubscription.cancel();
    facebookloginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc1 = Provider.of<AuthBloc1>(context);
    var authBloc2 = Provider.of<AuthBloc2>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              text: "Login with Google",
              padding: EdgeInsets.all(3.0),
              onPressed: () => authBloc1.loginGoogle(),
            ),
            SizedBox(
              height: 30.0,
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Login with Facebook",
              padding: EdgeInsets.all(3.0),
              onPressed: () => authBloc2.loginFb(),
            ),
          ],
        ),
      ),
    );
  }
}
