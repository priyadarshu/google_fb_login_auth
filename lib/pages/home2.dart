import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fb_login_auth/blocs/auth_bloc.dart';
import 'package:google_fb_login_auth/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  StreamSubscription<User> facebookhomeStateSubscription;

  @override
  void initState() {
    var authBloc2 = Provider.of<AuthBloc2>(context, listen: false);
    facebookhomeStateSubscription =
        authBloc2.currentUser.listen((firebaseUser) {
      if (firebaseUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    facebookhomeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc2 = Provider.of<AuthBloc2>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<User>(
              stream: authBloc2.currentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                print(snapshot.data.photoURL);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data.photoURL + '?width=400&height500'),
                      radius: 60.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      snapshot.data.displayName,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      snapshot.data.email,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    SignInButtonBuilder(
                      icon: Icons.logout,
                      text: 'Sign Out',
                      onPressed: () => authBloc2.logout(),
                      backgroundColor: Colors.red,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
