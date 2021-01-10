import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fb_login_auth/blocs/auth_bloc.dart';
import 'package:google_fb_login_auth/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User> googlehomeStateSubscription;

  @override
  void initState() {
    var authBloc1 = Provider.of<AuthBloc1>(context, listen: false);

    googlehomeStateSubscription = authBloc1.currentUser.listen((firebaseUser) {
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
    googlehomeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc1 = Provider.of<AuthBloc1>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<User>(
              stream: authBloc1.currentUser,
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
                      onPressed: () => authBloc1.logout(),
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
