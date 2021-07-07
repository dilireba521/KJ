import 'package:flutter/cupertino.dart';

class MyRouter {
  static BuildContext _context;
  static BuildContext get context => _context;
  static set setContext(_c) => _context = _c;

  /*
    获取页面参数
    @context
    @defaultData
   */
  static T getPageArguments<T>(context, defaultData) {
    RouteArguments<T> _args = ModalRoute.of(context).settings.arguments ??
        RouteArguments<T>(defaultData);
    return _args.args;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class RouteArguments<T> {
  final T args;

  RouteArguments(this.args);
}
