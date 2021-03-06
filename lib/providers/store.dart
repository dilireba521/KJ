import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store {
  static init({context, child}) {
    //多个Provider
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<ThemeProvider>.value(value: ThemeProvider()),
      ],
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T value<T>(context) {
    return Provider.of<T>(context);
  }

  // 不会引起页面的刷新，只刷新了 Consumer 的部分，极大地缩小你的控件刷新范围
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
