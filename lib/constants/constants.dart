//定义一个常量文件便于管理颜色值
abstract class AppColors {
  //应用的主题色
  static const APP_THEME = 0xff63ca6c;

  //标题栏颜色
  static const APPBAR = 0xffffffff;
}

//开源中国API
abstract class AppInfos {
  static const String CLIENT_ID = 'zfBPjG9NzRLIaaJxM1Dh';//应用ID
  static const String CLIENT_SECRET = 'h6VWQu48lGcJmjm3bhVfznYZwvXCqq6n';//应用私钥
  static const String REDIRECT_URI = 'https://www.cnblogs.com/rohank/';//回调地址
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';

  //OpenAPI 授权登录页面
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';

  //authorization_code 方式获取 AccessToken
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';

  //获取登陆用户信息
  static const String OPENAPI_USER = HOST + '/action/openapi/user';

  //获取用户详情
  static const String MY_INFORMATION = HOST + '/action/openapi/my_information';

  //获得用户私信列表
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';

  //获取新闻列表
  static const String NEWS_LIST = HOST + '/action/openapi/news_list';

  //获取新闻详情
  static const String NEWS_DETAIL = HOST + '/action/openapi/news_detail';

  //获取动弹列表 （最新动弹列表 我的动弹）
  static const String TWEET_LIST  = HOST + '/action/openapi/tweet_list';
}