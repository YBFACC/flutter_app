import 'package:flutter/material.dart';
import 'package:flutter_app/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();

}

class _MyPageState extends State<MyPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: WebView(
            url: 'https//m.ctrip.com/webapp/myctrip/',
            hideAppBar: true,
            backForbid: true,
            statusBarColor: '4c5bca',
          ),
        )
    );
  }

}