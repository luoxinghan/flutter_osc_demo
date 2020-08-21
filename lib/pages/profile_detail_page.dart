import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:flutter_osc_client/models/user_info.dart';
import 'package:flutter_osc_client/utils/data_utils.dart';
import 'package:flutter_osc_client/utils/net_utils.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  UserInfo _userInfo;

  _getDetailInfo() {
    DataUtils.getAccessToken().then((accessToken) {
      //拼装请求
      Map<String, dynamic> params = Map<String, dynamic>();
      params['dataType'] = 'json';
      params['access_token'] = accessToken;
      NetUtils.get(AppUrls.MY_INFORMATION, params).then((data) {
        print('MY_INFORMATION: $data');
        if (data != null && data.isNotEmpty) {
          Map<String, dynamic> map = json.decode(data);
          UserInfo userInfo = UserInfo();
          userInfo.uid = map['uid'];
          userInfo.name = map['name'];
          userInfo.gender = map['gender'];
          userInfo.province = map['province'];
          userInfo.city = map['city'];
          userInfo.platforms = map['platforms'];
          userInfo.expertise = map['expertise'];
          userInfo.joinTime = map['joinTime'];
          userInfo.lastLoginTime = map['lastLoginTime'];
          userInfo.portrait = map['portrait'];
          userInfo.fansCount = map['fansCount'];
          userInfo.favoriteCount = map['favoriteCount'];
          userInfo.followersCount = map['followersCount'];
          userInfo.notice = map['notice'];
          setState(() {
            _userInfo = userInfo;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '用户详情',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: _userInfo == null
          ? Center(child: CupertinoActivityIndicator())
          : Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    //TODO: 点击进入头像修改界面
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '头像',
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              image: DecorationImage(
                                  image: NetworkImage(_userInfo.portrait),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('昵称', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.name,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('昵称', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.name,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('加入时间', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.joinTime,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('所在地区', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.city,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              '开发平台',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              //'Android,C
                              _userInfo.platforms.toString(),
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              '专长领域',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              //'Android,C
                              _userInfo.expertise.toString(),
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('粉丝数', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.fansCount.toString(),
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('收藏数', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.favoriteCount.toString(),
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('关注数', style: TextStyle(fontSize: 15)),
                          Text(
                            _userInfo.followersCount.toString(),
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
