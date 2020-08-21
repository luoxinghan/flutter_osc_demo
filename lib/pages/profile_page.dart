import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/common/event_bus.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:flutter_osc_client/pages/login_web_page.dart';
import 'package:flutter_osc_client/pages/my_message_page.dart';
import 'package:flutter_osc_client/pages/profile_detail_page.dart';
import 'package:flutter_osc_client/utils/data_utils.dart';
import 'package:flutter_osc_client/utils/net_utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = ['我的消息', '阅读记录', '我的博客', '我的回答', '我的活动', '我的团队', '邀请好友'];
  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    //显示用户信息
    _showUserInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息并显示
      _getUserInfo();
      print('登陆成功，开始请求用户信息接口...');
    });
    eventBus.on<LogoutEvent>().listen((event) {
      //用户登出处理
      _showUserInfo();
    });
  }

  _getUserInfo() {
    //获取用户信息
    DataUtils.getAccessToken().then((accessToken) {
      //未获取到用户信息
      if (accessToken == null || accessToken.length == 0) {
        return;
      }
      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = accessToken;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.OPENAPI_USER, params).then((data) {
        print('_getUserInfo:$data');
        Map<String, dynamic> map = json.decode(data);
        if (mounted) {
          setState(() {
            userAvatar = map['avatar'];
            userName = map['name'];
          });
        }
        //保存用户信息
        DataUtils.saveUserInfo(map);
      });
    });
  }

  //显示用户信息
  _showUserInfo() {
    //需要封装一个获取当前用户信息的方法
    DataUtils.getUserInfo().then((user) {
      if(mounted) {
        setState(() {
          if(user != null) {
            userAvatar = user.avatar;
            userName = user.name;
          } else {
            userAvatar = null;
            userName = null;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            color: Color(AppColors.APP_THEME),
            height: 150.0,
            child: Center(
              //用户头像
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: userAvatar != null
                        ? Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                image: DecorationImage(
                                    image: NetworkImage(userAvatar),
                                    fit: BoxFit.cover)),
                          )
                        : Image.asset('assets/images/ic_avatar_default.png', width: 60.0, height: 60.0),
                    onTap: () {
                      //添加判断登陆状态的代码
                      DataUtils.isLogin().then((isLogin) {
                        if(isLogin) {
                          //已经登录则查看用户详情
                          Navigator.of(context).push(MaterialPageRoute(builder: (contenxt) => ProfileDetailPage()));
                        } else {
                          _login();
                        }
                      });
                    },
                  ), //手势 添加点击事件
                  SizedBox(
                    //加间距
                    height: 10.0,
                  ),
                  Text(
                    //userName ??= '点击头像登录' Dart语法 双问号左边为true返回左边结果 否则返回右边结果
                    userName != null ? userName : '点击头像登录',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          );
        }
        index = index - 1;
        return ListTile(
          leading: Icon(menuIcons[index]), //左图标
          title: Text(menuTitles[index]), //中间标题
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            DataUtils.isLogin().then((isLogin) {
              if(isLogin){
                switch(index) {
                  case 0:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyMessagePage()));
                    break;
                }
              }
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      }, //分割线
      itemCount: menuTitles.length + 1,
    );
  }

  void _login() async {
    //通过返回值进行登录验证
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == 'refresh') {
      //登录成功，需要通知请求用户信息接口
      eventBus.fire(LoginEvent());
    }
  }
}
