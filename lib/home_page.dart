import 'package:flutter/material.dart';
import 'package:flutter_osc_client/widgets/navigation_icon_view.dart';

//为了避免堆叠过多 所以移到一个新的文件内
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBarTitle = ['资讯', '动态', '发现', '我的'];
  final _appBarIconPath = [
    'assets/images/ic_nav_discover_normal.png',
    'assets/images/ic_nav_tweet_normal.png',
    'assets/images/ic_nav_discover_normal.png',
    'assets/images/ic_nav_news_normal.png'
  ];
  final _appBarActiveIconPath = [
    'assets/images/ic_nav_discover_actived.png',
    'assets/images/ic_nav_tweet_actived.png',
    'assets/images/ic_nav_discover_actived.png',
    'assets/images/ic_nav_news_actived.png'
  ];
  List<NavigationIconView> _navigationIconViews;

  var _currentIndex = 0;//当前菜单

  @override
  void initState() {
    super.initState();
    _navigationIconViews = [
      NavigationIconView(
          title: _appBarTitle[0],
          iconPath: _appBarIconPath[0],
          activeIconPath: _appBarActiveIconPath[0]),
      NavigationIconView(
          title: _appBarTitle[1],
          iconPath: _appBarIconPath[1],
          activeIconPath: _appBarActiveIconPath[1]),
      NavigationIconView(
          title: _appBarTitle[2],
          iconPath: _appBarIconPath[2],
          activeIconPath: _appBarActiveIconPath[2]),
      NavigationIconView(
          title: _appBarTitle[3],
          iconPath: _appBarIconPath[3],
          activeIconPath: _appBarActiveIconPath[3])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle[_currentIndex]),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationIconViews.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState((){
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
