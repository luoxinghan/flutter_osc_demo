import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:flutter_osc_client/pages/discovery_page.dart';
import 'package:flutter_osc_client/pages/news_list_page.dart';
import 'package:flutter_osc_client/pages/profile_page.dart';
import 'package:flutter_osc_client/pages/tweet_page.dart';
import 'package:flutter_osc_client/widgets/my_drawer.dart';
import 'package:flutter_osc_client/widgets/navigation_icon_view.dart';

//为了避免堆叠过多 所以移到一个新的文件内
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBarTitle = ['资讯', '动态', '发现', '我的'];
  final _appBarIconPath = [
    'assets/images/ic_nav_news_normal.png',
    'assets/images/ic_nav_tweet_normal.png',
    'assets/images/ic_nav_discover_normal.png',
    'assets/images/ic_nav_my_normal.png'
  ];
  final _appBarActiveIconPath = [
    'assets/images/ic_nav_news_actived.png',
    'assets/images/ic_nav_tweet_actived.png',
    'assets/images/ic_nav_discover_actived.png',
    'assets/images/ic_nav_my_pressed.png'
  ];
  List<NavigationIconView> _navigationIconViews;

  var _currentIndex = 0; //当前菜单

  //下面的组件页面
  List<Widget> _pages;

  //页面左右滑动效果 使用PageController
  PageController _pageController;

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

    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,//去掉阴影
        title: Text(
          _appBarTitle[_currentIndex],
          style: TextStyle(color: Color(AppColors.APPBAR),),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      //body: _pages[_currentIndex],使用PageController之前
      body: PageView.builder(
          //physics: NeverScrollableScrollPhysics(),这里可以阻止滑动
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() {
              //当其滑动时需要将底部导航栏也进行更新状态
              _currentIndex = index;
            });
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationIconViews.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(index,
              duration: Duration(microseconds: 1), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
        headImgPath: 'assets/images/cover_img.jpg',
        menuIcons: [Icons.send, Icons.home, Icons.error, Icons.settings],
        menuTitles: ['发布动态','动态小黑屋','关于','设置'],
      ),//侧滑菜单
    );
  }
}
