
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController accountController = new TextEditingController();
//   TextEditingController passwordController = new TextEditingController();

//   LoginViewModel _viewModel;

//   bool isShowPassWord = false;
//   int clickedTimes = 0;
//   String mUserName;

//   @override
//   void initState() {
//     super.initState();
//     _viewModel = LoginViewModel();
//     setState(() {
//       mUserName = SaveDataTool().getUserName();
//       print('mUserName:${mUserName}');
//       accountController.text = mUserName;
//     });

//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

//     SaveDataTool().saveBool(SGConstant.AGREE_AUTH, true);
//     protocolAlert();
//   }

//   protocolAlert() {
//     if (Platform.isIOS) {
//       return;
//     }
//     bool firstLogin = SaveDataTool().getValue(SGConstant.FIRST_LOGIN);
//     if (firstLogin != null) {
//       return;
//     }
//   }

//   void loginCommit() async {
//     registKeyboard();
//     String account = accountController.text;
//     String pwd = passwordController.text;
//     if (account == "") {
//       SGToast.show("请输入用户名");
//       return;
//     }
//     if (account.length > 30) {
//       SGToast.show("用户名长度过长，请重新输入");
//       return;
//     }
//     if (pwd == "") {
//       SGToast.show("请输入登录密码");
//       return;
//     }
//     if (pwd.length > 30) {
//       SGToast.show("密码长度过长，请重新输入");
//       return;
//     }

//     bool isAgree = SaveDataTool().getValue(SGConstant.AGREE_AUTH);
//     if (isAgree == null || isAgree == false) {
//       SGToast.show("请阅读并同意《隐私声明》");
//       return;
//     }
//     _viewModel.commit(account, pwd, callBack: () {
//       NavigatorUtils.push(context, SGRoutes.mainPage, clearStack: true);
//     });
//   }

//   showAuthAlert() {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         // useSafeArea: false,
//         builder: (BuildContext context) {
//           return AuthAlertWidget("", () {
//             Navigator.pop(context);
//             SaveDataTool().saveBool(SGConstant.FIRST_LOGIN, true);
//             SaveDataTool().saveBool(SGConstant.AGREE_AUTH, true);
//             setState(() {});
//           }, () {
//             Navigator.pop(context);
//           });
//         });
//   }

//   void registKeyboard() {
//     FocusScope.of(context).requestFocus(FocusNode());
//   }

//   void showPassWord() {
//     registKeyboard();
//     setState(() {
//       isShowPassWord = !isShowPassWord;
//     });
//   }

//   void clearAccount() {
//     accountController.clear();
//   }

//   void switchHost() {
//     registKeyboard();
//     clickedTimes += 1;
//     if (clickedTimes >= 6) {
//       NavigatorUtil.pushTransitionLR(context, SwitchHostPage());
//       clickedTimes = 0;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     SGScreenUtil.initScreenUtil(context);
//     SystemUiOverlayStyle style = SGUICommon.overlayStyle();
//     SystemUiOverlayStyle style1 = SystemUiOverlayStyle(
// //      statusBarColor: null,
//       statusBarColor: Colors.transparent,
//       systemNavigationBarColor: style.systemNavigationBarColor,
//       systemNavigationBarDividerColor: style.systemNavigationBarDividerColor,
//       systemNavigationBarIconBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness: Brightness.light,
//     );

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: style1,
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//                 child: MediaQuery.removePadding(
//                     removeTop: true,
//                     removeBottom: true,
//                     context: context,
//                     child: SafeArea(
//                       child: ListView(
//                         children: [
//                           Container(
//                               height: MediaQuery.of(context).size.height,
//                               width: MediaQuery.of(context).size.width,
//                               color: Colors.white,
//                               child: ProviderWidget<LoginViewModel>(
//                                 model: _viewModel,
//                                 onReady: null,
//                                 builder: (context, model, child) {
//                                   return content1();
//                                 },
//                               ))
//                         ],
//                       ),
//                     )))));
//   }

//   Widget content1() {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double imgHeight = SGScreenUtil.h(200);
//     double paddingTop = SGScreenUtil.h(70);
//     double cardHeight = height - imgHeight - paddingTop;
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Column(
//           children: [
//             SizedBox(
//               height: SGScreenUtil.h(70),
//             ),
//             GestureDetector(
//               onTap: () {
//                 switchHost();
//               },
//               child: Container(
//                   child: LoadAssetImage(
//                 "login/login_bg",
//                 height: SGScreenUtil.h(200),
//               )),
//             )
//           ],
//         ),
//         Positioned(
//           top: imgHeight + paddingTop - 10,
//           child: Container(
//             width: width,
//             // color: Colors.amber,
//             height: cardHeight + 10,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: new BorderRadius.only(
//                     topLeft: Radius.circular(SGScreenUtil.w(26.0)),
//                     topRight: Radius.circular(SGScreenUtil.w(26.0))),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color(0xFFBFDCFF).withAlpha(140),
//                       offset: Offset(0.0, -2.0),
//                       blurRadius: 5.0,
//                       spreadRadius: 0)
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: SGScreenUtil.h(30),
//                 ),
//                 Text(
//                   "QOMO",
//                   style: TextStyle(
//                       color: ThemeColors.app_main,
//                       fontSize: SGScreenUtil.s(40),
//                       fontFamily: SGConstant.PingFangLight),
//                 ),
//                 SizedBox(
//                   height: SGScreenUtil.h(30),
//                 ),
//                 Container(
//                   width: width * 0.8,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: accountController,
//                         decoration: new InputDecoration(
//                             icon: Container(
//                               width: 22,
//                               height: 22,
//                               // color: Colors.amber,
//                               child: LoadImage(
//                                 "login/account",
//                                 width: SGScreenUtil.w(26),
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             hintText: "请输入用户名",
//                             hintStyle: TextStyle(
//                                 fontSize: SGScreenUtil.s(14),
//                                 color: Color(0xFF949494)),
//                             suffixIcon: IconButton(
//                               onPressed: clearAccount,
//                               icon: accountController.text.length > 0
//                                   ? Icon(Icons.highlight_remove,
//                                       size: SGScreenUtil.s(20),
//                                       color: Color(0x99949494))
//                                   : Container(),
//                             ),
//                             border: InputBorder.none),
//                         style: new TextStyle(
//                             fontSize: SGScreenUtil.s(15), color: Colors.black),
//                         onSaved: (value) {},
//                       ),
//                       SGUICommon.divider(
//                           paddingLeft: 0, color: Color(0xffDADADA)),
//                       SizedBox(
//                         height: SGScreenUtil.h(15),
//                       ),
//                       TextFormField(
//                         controller: passwordController,
//                         decoration: new InputDecoration(
//                             icon: Container(
//                                 width: 22,
//                                 height: 22,
//                                 // color: Colors.amber,
//                                 child: LoadImage(
//                                   "login/pwd",
//                                   width: SGScreenUtil.w(22),
//                                 )),
//                             hintText: "请输入密码",
//                             border: InputBorder.none,
//                             hintStyle: TextStyle(
//                                 fontSize: SGScreenUtil.s(14),
//                                 color: Color(0xFF949494)),
//                             suffixIcon: new IconButton(
//                                 icon: Container(
//                                     width: 30,
//                                     height: 30,
//                                     padding: EdgeInsets.all(6),
//                                     // color: Colors.amber,
//                                     child: LoadImage(
//                                       isShowPassWord
//                                           ? "login/pwd_show"
//                                           : "login/pwd_hide",
//                                       // width: SGScreenUtil.w(16),
//                                       fit: BoxFit.contain,
//                                     )),
//                                 onPressed: showPassWord)),
//                         obscureText: !isShowPassWord,
//                         style: new TextStyle(
//                             fontSize: SGScreenUtil.s(15), color: Colors.black),
//                         onSaved: (value) {},
//                       ),
//                       SGUICommon.divider(
//                           paddingLeft: 0, color: Color(0xffDADADA)),
//                       SizedBox(
//                         height: SGScreenUtil.h(40),
//                       ),
//                       protocolWidget(),
//                       SizedBox(
//                         height: SGScreenUtil.h(30),
//                       ),
//                       CommitButton(
//                         text: "登录",
//                         height: SGScreenUtil.h(45),
//                         width: width * 0.8,
//                         pressed: () {
//                           // comformAlert();
//                           loginCommit();
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget protocolWidget() {
//     bool isAgree = SaveDataTool().getValue(SGConstant.AGREE_AUTH);
//     if (isAgree == null) {
//       isAgree = false;
//     }
//     return GestureDetector(
//       onTap: () {
//         bool isAgree = SaveDataTool().getValue(SGConstant.AGREE_AUTH);
//         if (isAgree == null) {
//           SaveDataTool().saveBool(SGConstant.AGREE_AUTH, true);
//         } else {
//           isAgree = !isAgree;
//           SaveDataTool().saveBool(SGConstant.AGREE_AUTH, isAgree);
//         }
//         setState(() {});
//       },
//       child: Container(
//         height: SGScreenUtil.h(20),
//         child: Row(
//           children: <Widget>[
//             LoadImage(
//               isAgree ? "login/protocol_check" : "login/protocol_uncheck",
//               width: SGScreenUtil.w(14),
//               fit: BoxFit.contain,
//             ),
//             SizedBox(
//               width: SGScreenUtil.w(6),
//             ),
//             Text("我已阅读并同意",
//                 style: TextStyle(
//                     fontSize: SGScreenUtil.s(12),
//                     color: Color(0xFF666666),
//                     fontFamily: SGConstant.PingFangMedium)),
//             GestureDetector(
//               onTap: () {
//                 showAuthAlert();
//               },
//               child: Text("《隐私声明》",
//                   style: TextStyle(
//                       fontSize: SGScreenUtil.s(12),
//                       color: Color(0xFF333333),
//                       fontFamily: SGConstant.PingFangRegular,
//                       fontWeight: FontWeight.bold)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
