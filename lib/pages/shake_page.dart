import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShaked = false;
  int _currentIndex = 0;
  StreamSubscription _streamSubscription;
  static const int SHAKE_TIMEOUT = 500;
  static const double SHAKE_THRESHOLD = 3.25;
  var _lastTime = 0;

  @override
  void initState() {
    super.initState();
    _streamSubscription = accelerometerEvents.listen((event){
      var now = DateTime.now().millisecondsSinceEpoch;
      if((now - _lastTime) > SHAKE_TIMEOUT) {
        var x = event.x;
        var y = event.y;
        var z = event.z;
        double acce =
            sqrt(x * x + y * y + z * z) - 9.8; //9.8是g，加速度公式
        if(acce > SHAKE_THRESHOLD) {
          print('摇一摇');
          Vibration.vibrate();
          //手机晃动了
          _lastTime = now;
          if(!mounted) return;
          setState((){
            isShaked = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('摇一摇', style: TextStyle(color: Color(AppColors.APPBAR))),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/shake.png', width: 120, height: 120),
            SizedBox(
              height: 10.0,
            ),
            Text(isShaked ? '活动已结束！' : '摇一摇获取礼品')
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.folder), title: Text('礼品')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('资讯'))
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if(!mounted) return;
          setState((){
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
