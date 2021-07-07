import 'api.dart';

class ApiUrl {
  //登陆页面
  static String login() {
    return Api.HostUrl + "identity/auth/login/";
  }

  static String logout() {
    return Api.HostUrl + "identity/auth/logout/";
  }
}
