import 'package:flutter/material.dart';
import 'main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class mainActivity extends StatefulWidget {
  @override
  _mainActivityState createState() => _mainActivityState();
}

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class _mainActivityState extends State<mainActivity> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('appicona');
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        priority: Priority.Max,
        importance: Importance.Max,
        playSound: false,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'HeadPhoneSafe Alert', 'We heard something', notificationDetails);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }


  var lifeMean = 0.0;

  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter = new NoiseMeter();

  var leng = 0;
  var sum = 0.0;
  var a = true;

  onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }
    });
    print(noiseReading.toString());
    var rreadMDD = noiseReading.meanDecibel;
    //var irreadMDD = rreadMDD.toInt();
    lifeList.add(rreadMDD);
    if(lifeList.length>=100){
      lifeList.removeRange(0, 99);
      sum = 0;
    }
    iList.add(rreadMDD);
    if(iList.length>=20){
      iList.removeAt(0);
    }
    var readMDS = rreadMDD.toString();
    dbList.add(readMDS);
    var len = dbList.length;
    leng = len;
    meaner();
    isSpike();
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  List<String> dbList = [];
  List<double> iList = [0];
  List<double> lifeList = [0];

  int cleanData(){
    dbList.removeRange(0, leng - 1);
    return 0;
  }

  var avg = 0.0;

   meaner(){
    if(_isRecording){
      sum = sum + lifeList[lifeList.length - 1];
      avg = sum/(lifeList.length);
    }
   }

   var dataContent = 0;

   isSpike(){
     if(_isRecording){
       if(lifeList[lifeList.length - 1] - avg < 0.25*avg){
         dataContent = 0;
       }
       if(lifeList[lifeList.length - 1] - avg >= 0.25*avg && lifeList[lifeList.length - 1] - avg < 0.35*avg){
         dataContent = 1;
         _showNotifications();
       }
       if(lifeList[lifeList.length - 1] - avg >= 0.35*avg){
         dataContent = 2;
         _showNotifications();
       }
     }
   }

   alertContent(){
     if(dataContent == 0){
       return Padding(
         padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 0, bottom: 0),
         child: Container(
           height: screenHeight(context,
               mulBy: 0.10),
           width: double.infinity,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
             boxShadow: [BoxShadow(
               offset: const Offset(0.0, 2.0),
               blurRadius: 3.0,
               spreadRadius: 0.0,
               color: Colors.grey,
             )],
           ),
         ),
       );
     }
     if(dataContent == 1){
       return Padding(
         padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 0, bottom: 0),
         child: Container(
           height: screenHeight(context,
               mulBy: 0.10),
           width: double.infinity,
           decoration: BoxDecoration(
             color: Colors.yellowAccent,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
             boxShadow: [BoxShadow(
               offset: const Offset(0.0, 2.0),
               blurRadius: 3.0,
               spreadRadius: 0.0,
               color: Colors.grey,
             )],
           ),
         ),
       );
     }
     if(dataContent == 2){
       return Padding(
         padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 0, bottom: 0),
         child: Container(
           height: screenHeight(context,
               mulBy: 0.10),
           width: double.infinity,
           decoration: BoxDecoration(
             color: Colors.redAccent,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
             boxShadow: [BoxShadow(
               offset: const Offset(0.0, 2.0),
               blurRadius: 3.0,
               spreadRadius: 0.0,
               color: Colors.grey,
             )],
           ),
         ),
       );
     }
   }

  List<Widget> getContent() => <Widget>[
    Container(
        margin: EdgeInsets.all(25),
        child: Column(children: [
          Text(_isRecording ? "Mic: ON" : "Mic: OFF",
              style: TextStyle(fontSize: 25, color: Colors.blue)
          ),
          Column(
            children: <Widget>[
              Text(
                _isRecording ? dbList[leng-1] : 'Not Listening',
              ),
              Text(
                "$leng",
              )
            ],
          )
        ])),
  ];

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
        color: Colors.white,
        child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: screenHeight(context,
                      mulBy: 0.284),
                  child: Lottie.asset('assets/10008-music-note-character.json'),
                ),
                Container(
                  width: 130,
                  child: OutlineButton(
                    onPressed: _isRecording ? stop : start,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.power_settings_new),
                            Text("Mic On/Off")
                          ]
                      ),
                  ),
                ),
                alertContent(),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 0, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1.70,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                              color: Color(0xff232d37),
                              boxShadow: [BoxShadow(
                                //offset: const Offset(3.0, 3.0),
                                blurRadius: 8.0,
                                spreadRadius: 2.0,
                                color: Colors.blueGrey,
                              )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                            child: LineChart(
                              mainData(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight(context,
                            mulBy: 0.09),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff232d37),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
                            boxShadow: [BoxShadow(
                              offset: const Offset(0.0, 8.0),
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              color: Colors.blueGrey,
                            )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _isRecording ? "Mean: $avg" : "Mean : N.A.",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              _isRecording ? "Spike Detection Active" : "Spike Detection Off",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 8),

          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 40:
                return '40';
              case 80:
                return '80';
              case 120:
                return '120';
              case 160:
                return '160';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 18,
      minY: 0,
      maxY: 160,
      lineBarsData: [
        LineChartBarData(
          spots: iList.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}