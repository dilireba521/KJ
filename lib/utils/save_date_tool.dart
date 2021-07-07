import 'package:kj/resource/constant.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'log.dart';

class SaveDataTool {
  factory SaveDataTool() => _getInstance();
  static SaveDataTool get instance => _getInstance();
  static SaveDataTool _instance;
  String token = "";

  SaveDataTool._internal();

  static SaveDataTool _getInstance() {
    if (_instance == null) {
      _instance = SaveDataTool._internal();
    }
    return _instance;
  }

  static SharedPreferences _sp;
  static PackageInfo packageInfo;
  Future<bool> initSharedPreferences() async {
    _sp = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
    return true;
  }

  //该字段是否存在
  bool containsKey(String key) {
    return _sp.containsKey(key);
  }

  //删除特定字符串
  void removeKey(String key) {
    if (key != null && _sp.containsKey(key)) {
      _sp.remove(key);
    }
  }

  //设置字符串
  void saveStr(String key, String value) async {
    if (key == null || key.length <= 0) {
      SGLog.e("key 为空，保存失败");
      return;
    }
    if (value == null) {
      value = "";
    }
    await _sp.setString(key, value);
  }

  //设置数组
  void saveStrList(String key, List<String> value) async {
    if (key == null || key.length <= 0) {
      SGLog.e("key 为空，保存失败");
      return;
    }
    if (value == null) {
      value = [];
    }
    await _sp.setStringList(key, value);
  }

  //设置bool值
  void saveBool(String key, bool value) async {
    if (key == null || key.length <= 0) {
      SGLog.e("key 为空，保存失败");
      return;
    }
    if (value == null) {
      return;
    }
    await _sp.setBool(key, value);
  }

  dynamic getValue(String key) {
    if (key == null || key.length <= 0) {
      SGLog.e("key 为空，获取失败");
      return "";
    }
    dynamic value = _sp.get(key);
    return value;
  }

  bool getBool(String key) {
    if (key == null || key.length <= 0) {
      SGLog.e("key 为空，获取失败");
      return false;
    }
    dynamic value = _sp.get(key);
    return value;
  }

  //获取用户当前token
  String getToken() {
    if (token != null && token.length > 0) {
      return token;
    }
    String tokenValue = getValue(SGConstant.TOKEN);
    token = tokenValue;
    return token;
  }

  String getFormatToken() {
    String formatTk = "Token mobile:$token";
    return formatTk;
  }

  //保存用户当前token数据
  void saveToken(String tokenValue) async {
    if (tokenValue == null || tokenValue.length <= 0) {
      SGLog.e("token 为空，保存token失败");
      return;
    }
    token = tokenValue;
    saveStr(SGConstant.TOKEN, tokenValue);
  }

  void logout() {
    token = null;
    saveStr(SGConstant.TOKEN, null);
    // _sp.clear();
  }
}
