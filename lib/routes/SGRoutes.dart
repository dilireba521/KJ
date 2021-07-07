import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:kj/pages/main/main_page.dart';

import 'i_router.dart';

class SGRoutes {
  // 路由管理
  static FluroRouter router;

  static String root = "/";
  static String loginPage = "/loginPage";
  static String mainPage = "/mainPage";

  static final List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {
    // 未发现对应route
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('route not found!');
      return Center(
        child: Text("你发现了彩蛋页面！"),
      );
    });
    router.define(mainPage,
        handler: Handler(handlerFunc: (_, __) => MainPage()));
    // router.define(loginPage, handler: Handler(handlerFunc: (_, __) => Login()));
    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    // _listRouter.add(MeRouter());
    // _listRouter.add(NoticeRouter());
    // _listRouter.add(HomeRouter());
    // _listRouter.add(AppsRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateTo(BuildContext context, String path,
      {Map<dynamic, dynamic> params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.native}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(
            params[key].runtimeType.toString() != "String"
                ? jsonEncode(params[key])
                : params[key]);

        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    // print('我是navigateTo传递的参数：$query');

    path = path + query;
    return router.navigateTo(
      context,
      path,
      transition: transition,
      replace: replace,
      clearStack: clearStack,
    );
  }
}
