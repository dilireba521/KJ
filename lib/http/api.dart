class Api {
  static const String CONTENT_TYPE = "application/json;charset=UTF-8";
  static const int CONNECT_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 5000;

  static const String DEBUG_HOST = 'https://192.168.102.124:8002/api/';
  static const String DEV_HOST = 'https://central.dev.goqomo.com/api/';
  static String RELEASE_HOST = 'https://central.goqomo.com/api/';
  // ignore: non_constant_identifier_names
  static String HostUrl = RELEASE_HOST;
}

class HttpConfig {
  static const bool DEBUG = false;
  static const String CONTENT_TYPE = "application/json;charset=UTF-8";
  static const int CONNECT_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 5000;
}
