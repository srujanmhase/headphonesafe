import 'package:flutter/material.dart';
import 'main.dart';

class mainSettings extends StatefulWidget {
  @override
  _mainSettingsState createState() => _mainSettingsState();
}

class _mainSettingsState extends State<mainSettings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                      width: 50,
                      child: FlatButton(
                          child: Icon(Icons.close),
                          onPressed: (){
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Pivacy Information",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                          "$longString"
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("* 'Firebase' is the registered trademark of Google Inc.", style: TextStyle(fontSize: 11),),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var longString = "From the very beggining of ideation stage of this app right till the end of development stage, we strived relentlessly root out any need for sensitive user data to be uploaded to any server. To that end, all spike detection algorithms and ML Models run right on your device. No audio data, precise location data, sensitive personal information is ever uploaded to the internet. Only the most basic app analytics is collected by Firebase Analytics*.";