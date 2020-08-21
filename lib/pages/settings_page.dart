import 'package:flutter/material.dart';
import 'package:flutter_osc_client/common/event_bus.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:flutter_osc_client/utils/data_utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('设置', style: TextStyle(color: Color(AppColors.APPBAR))),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () {
              DataUtils.clearLoginInfo().then((_) {
                eventBus.fire(LogoutEvent()); //发出退出消息
                Navigator.of(context).pop();
              });
            },
            child: Text('退出登录', style: TextStyle(fontSize: 25))),
      ),
    );
  }
}
