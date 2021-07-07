import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'components/image/load_image.dart';
import 'components/loading/CustomLoadingAnimation.dart';
import 'pages/main/main_page.dart';
import 'providers/store.dart';
import 'routes/SGRoutes.dart';
import 'routes/router.dart';
import 'utils/save_date_tool.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //初始化sp
  SaveDataTool().initSharedPreferences();
  //初始化路由
  final router = FluroRouter();
  SGRoutes.configureRoutes(router);
  SGRoutes.router = router;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initLoading();
  }

  void initLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60.0
      ..radius = 10.0
      ..backgroundColor = Colors.white
      ..textColor = Color(0xFF333333)
      ..maskColor = Colors.black.withOpacity(0.2)
      ..userInteractions = false
      ..dismissOnTap = false
      ..infoWidget = Container(
        width: 60,
        height: 60,
        child: LoadImage("common/info"),
      )
      ..customAnimation = CustomLoadingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    // 除半透明状态栏
    if (Theme.of(context).platform == TargetPlatform.android) {
      // android 平台
      SystemUiOverlayStyle _style =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(_style);
    }

    /// 处理首页显示
    String token = SaveDataTool().getToken();
    Widget home = Login();
    // if (token != null && token.length > 0) {
    home = MainPage();
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'KJ',
      onGenerateRoute: SGRoutes.router.generator, //路由初始化
      home: home,
      navigatorKey: MyRouter.navigatorKey,
      builder: EasyLoading.init(),
    );
  }
}

Widget Login() {}
