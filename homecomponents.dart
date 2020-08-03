import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';
import 'mainDark.dart';
import 'activity.dart';
import 'darkcomponents.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/cupertino.dart';

class homeComponents extends StatefulWidget {
  @override
  _homeComponentsState createState() => _homeComponentsState();
}
var mainColor = Colors.white;
class _homeComponentsState extends State<homeComponents> {

  createAlertDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Important"),
        content: Text("Put the ringer on silent and keep the device in you field of vision"),
        actions: <Widget>[
          MaterialButton(onPressed: (){}, child: Text("Done"),)
        ],
      );
    });
  }
  
  createCupDiag(BuildContext context){
    return showCupertinoDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        title: Text("Important"),
        content: Text("Put the ringer on silent and keep the device in your field of vision. Kindly ignore the first notification."),
        actions: <Widget>[
          CupertinoButton(
              child: Text("Done"),
              onPressed: (){
                Navigator.of(context).push(startToActivityRoute());
              }
          ),
          CupertinoButton(
              child: Text("Back", style: TextStyle(color: Colors.redAccent),),
              onPressed: (){
                Navigator.of(context).pop();
              }
          )
        ],
      );
    });
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  double screenHeight(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).height * mulBy;
  }
  double screenWidth(BuildContext context, {double mulBy = 1}) {
    return screenSize(context).width * mulBy;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
            height: screenHeight(context,
                mulBy: 0.08),
            ),
            SizedBox(
              height: screenHeight(context,
                  mulBy: 0.24),
              child: Center(
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 120.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shadowColor: Colors.blueAccent,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: FlatButton(
                        shape: CircleBorder(),
                        onPressed: (){
                          createCupDiag(context);
                          //Navigator.of(context).push(startToActivityRoute());
                        },
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      radius: 50.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context,
                  mulBy: 0.05),
            ),
            LiteRollingSwitch(
              //initial value
              value: true,
              textOn: 'Light',
              textOff: 'Dark',
              colorOn: Colors.blueAccent,
              colorOff: Colors.grey[800],
              iconOn: Icons.wb_sunny,
              iconOff: Icons.lightbulb_outline,
              textSize: 16.0,
              onChanged: (bool state) {
                if (state == false) {
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.of(context).push(_createRoute());
                  });
                }
              },
            ),
            Container(
              height: screenHeight(context,
                  mulBy: 0.284),
                child: Lottie.asset('assets/25869-student.json')
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => darkMain(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route startToActivityRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => mainActivity(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
