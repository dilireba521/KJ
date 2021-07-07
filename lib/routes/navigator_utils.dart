import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'SGRoutes.dart';
import 'router.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {
  static FluroRouter router;

  static push(BuildContext context, String path,
      {Map<dynamic, dynamic> params,
      bool replace = false,
      bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    SGRoutes.navigateTo(context, path,
        params: params,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.cupertino);
  }

  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {Map<dynamic, dynamic> params,
      bool replace = false,
      bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    SGRoutes.navigateTo(context, path,
            params: params,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.cupertino)
        .then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  //TODO 需要返回登陆页时
  static toLogin() {
    // MyRouter.navigatorKey.currentState.pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => Login()),
    //     (route) => false);
  }
}
