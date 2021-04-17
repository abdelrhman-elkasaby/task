import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_isaak/screens/settingsScreen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return user;
    }catch (e) {
      print(e.message);
    }
  }
  loginWithFacebook() async {
    final facebookLogin = new FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SettingsScreen()));
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('CANCELED BY USER');
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text('Please Login To Continue...',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            const SizedBox(height: 150,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 65,vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
                onPressed: (){
              _googleSignUp().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SettingsScreen())));
            }, child: Text('Login With Google...',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),

            ElevatedButton(
                onPressed: loginWithFacebook,
                child: Text('Login With Facebook...',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
