import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc_client/pages/common_web_page.dart';
import 'package:flutter_osc_client/pages/shake_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '开源众包': Icons.pageview,
      '开源软件': Icons.speaker_notes_off,
      '码云推荐': Icons.screen_share,
      '代码片段': Icons.assignment,
    },
    {
      '扫一扫': Icons.camera_alt,
      '摇一摇': Icons.camera,
    },
    {'码云封面人物': Icons.person, '线下活动': Icons.android}
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: blocks.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0), //垂直上下增加10个间距
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.0, color: Color(0xffaaaaaa)),
                    bottom: BorderSide(width: 1.0, color: Color(0xffaaaaaa)))),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, itemIndex) {
                  return InkWell(
                    onTap: () {
                      _handleItemClick(blocks[index].keys.elementAt(itemIndex));
                    },
                    child: Container(
                      child: ListTile(
                        leading:
                            Icon(blocks[index].values.elementAt(itemIndex)),
                        title: Text(blocks[index].keys.elementAt(itemIndex)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, itemIndex) {
                  return Divider();
                },
                itemCount: blocks[index].length),
          );
        });
  }

  void _navToWebPage(String title, String url) {
    if (title != null && url != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommonWebPage(title: title, url: url)));
    }
  }

  void _handleItemClick(String itemTitle) {
    switch (itemTitle) {
      case '开源众包':
        _navToWebPage(itemTitle, 'https://zb.oschina.net/');
        break;
      case '扫一扫':
        scan();
        break;
      case '摇一摇':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShakePage()));
    }
  }

  void scan() async {
    var scanResult = await BarcodeScanner.scan();
    print('ScanResult: $scanResult');
  }
}
