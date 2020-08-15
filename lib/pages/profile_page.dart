import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:flutter_osc_client/pages/login_web_page.dart';

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
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                          image: DecorationImage(
                              image:
                              AssetImage('assets/images/ic_avatar_default.png'),
                              fit: BoxFit.cover)),
                    ),
                    onTap: (){
                      _login();
                    },
                  ),//手势 添加点击事件
                  SizedBox(
                    //加间距
                    height: 10.0,
                  ),
                  Text(
                    '点击头像登录',
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
          title: Text(menuTitles[index]),//中间标题
          trailing: Icon(Icons.arrow_forward_ios),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },//分割线
      itemCount: menuTitles.length + 1,
    );
  }

  void _login(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWebPage()));
  }
}
