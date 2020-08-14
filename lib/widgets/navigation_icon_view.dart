import 'package:flutter/material.dart';

//封装导航栏
class NavigationIconView {
  //item
  final BottomNavigationBarItem item;

  //title
  final String title;

  //icon path
  final String iconPath;

  //actived icon path
  final String activeIconPath;

  NavigationIconView(
      {@required this.title,
      @required this.iconPath,
      @required this.activeIconPath})
      : item = BottomNavigationBarItem(
            icon: Image.asset(iconPath, width: 20.0, height: 20.0),
            activeIcon: Image.asset(
              activeIconPath,
              width: 20.0,
              height: 20.0,
            ),
            title: Text(title)
  );
}
