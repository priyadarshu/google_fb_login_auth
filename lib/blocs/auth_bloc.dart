import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fb_login_auth/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc1 {
  final auth1Service = AuthService();
  final googleSignin = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => auth1Service.currenUser;

//
// Google Login Code for Authentication
//
  loginGoogle() async {
    print('starting google login');

    try {
      final GoogleSignInAccount googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential gcredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final result = await auth1Service.signInWithCredential(gcredential);
      print('${result.user.displayName}');
    } catch (error) {
      print(error);
    }
  }

//
// Firebase sign out
//
  logout() {
    auth1Service.logOut();
  }
}

class AuthBloc2 {
  final auth2Service = AuthService();
  final fb = FacebookLogin();
  Stream<User> get currentUser => auth2Service.currenUser;

//
  // Facebook Login Code for Authentication
//
  loginFb() async {
    print('starting facebook login');

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        print('It worked');
        //get token
        final FacebookAccessToken fbtoken = res.accessToken;
        //convert to firebase auth credential
        final AuthCredential fcredential =
            FacebookAuthProvider.credential(fbtoken.token);
        //user credential to signin with firebase
        final result = await auth2Service.signInWithCredential(fcredential);
        print('${result.user.displayName}');
        break;

      case FacebookLoginStatus.cancel:
        print('The user cancelled the Facebook login');
        break;
      case FacebookLoginStatus.error:
        print('There is an error');
        break;
      default:
    }
  }

//
// Firebase sign out
//
  logout() {
    auth2Service.logOut();
  }
}
