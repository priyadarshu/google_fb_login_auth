import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fb_login_auth/blocs/auth_bloc.dart';
import 'package:google_fb_login_auth/pages/login.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBloc1>(
          create: (context) => AuthBloc1(),
        ),
        Provider<AuthBloc2>(
          create: (context) => AuthBloc2(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SignIn Authenticator App",
        theme: ThemeData(
          primaryColor: Colors.blueGrey[700],
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
