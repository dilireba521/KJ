import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages;
  List<String> appBarTitles = ['门店', '应用', '我的'];
  int selectedTabIndex = 0;
  PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("dasd"),
    );
  }
}
