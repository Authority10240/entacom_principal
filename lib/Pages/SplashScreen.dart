import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:entacomprincipal/BackEnd/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:entacomprincipal/Pages/Entacom_home.dart';
import 'package:entacomprincipal/Pages/Select_School.dart';
import 'package:entacomprincipal/Pages/loginpage.dart';


/// Run first apps open
void main() {
  runApp(myApp());
}

/// Set orienttation
class myApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    return new MaterialApp(
      title: "+Up",
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.redAccent,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      /// Move splash screen to ChoseLogin Layout
      /// Routes
     /* routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => new LoginPage(),
      },*/
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

/// Component UI
class _SplashScreenState extends  State<SplashScreen> {
  SharedPreferences sp;
  @override
  /// Setting duration in splash screen
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), NavigatorPage);
  }
   Future<bool> CheckSchool()async{
    bool hasSchool= false;
    sp = await SharedPreferences.getInstance();

    if(sp.getString('SCHOOL_NAME') != null){
      hasSchool = true;
      Strings.SCHOOL_NAME = sp.getString('SCHOOL_NAME');
    }

    return hasSchool;
  }
  Future<bool> checkVirginity() async {
    bool virgin;
    SharedPreferences virginity = await SharedPreferences.getInstance();
    virgin = virginity.getBool('Virginity');
    return virgin;
  }
  /// To navigate layout change
  void NavigatorPage() async {
    if(await checkVirginity() == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
      else if(!await CheckSchool()){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => School_Select()));
      }else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EntacomHome()));
      }
  }
  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    startTime();
  }
  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
        ),
        child: Container(
          /// Set gradient black in image splash screen (Click to open code)
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.4)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    /// Text header "Welcome To" (Click to open code)
                    Hero(
                      tag: "Logo",
                      child: Image.asset(
                        'assets/logo2.png',
                        width: 120.0,
                        height: 120.0,

                      ),

                    ),
                    Text(
                      "Entacom Principal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Sans",
                        fontSize: 35.0,
                      ),
                    ),
                    /// Animation text Treva Shop to choose Login with Hero Animation (Click to open code)
                    Hero(
                      tag: "+Up",
                      child: Text(
                        "Unparalleled Supervision",
                        style: TextStyle(
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                          letterSpacing: 0.4,
                          color: Colors.white,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }










}
