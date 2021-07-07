import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'api.dart';
import 'intercept.dart';

class HttpUtil {
  factory HttpUtil() => _httpInstance();
  static HttpUtil _instance;
  Dio _dio;
  BaseOptions orgOption;
  CancelToken cancelToken = CancelToken();
  ConnectivityResult connectionStatus;
  List<Interceptor> interceptorList = [TokenIntercept(), AdapterInterceptor()];
  static HttpUtil _httpInstance() {
    if (_instance == null) {
      _instance = HttpUtil._init();
    }
    return _instance;
  }

  HttpUtil._init() {
    resetHeader();
    _dio = new Dio(orgOption);
    addInterceptors();
  }

  resetHeader() {
    orgOption = BaseOptions(
        connectTimeout: HttpConfig.CONNECT_TIMEOUT,
        receiveTimeout: HttpConfig.RECEIVE_TIMEOUT,
        baseUrl: Api.HostUrl);
    orgOption.headers = {};
  }

//拦截器添加
  addInterceptors() {
    if (null != _dio) {
      _dio.interceptors.addAll(interceptorList);
      if (HttpConfig.DEBUG) {
        _dio.interceptors.add(LogInterceptor(
            responseBody: true,
            error: true,
            requestHeader: false,
            responseHeader: true,
            request: false,
            requestBody: false));
      }
    }
  }

  /// get 请求
  void get(String url,
      {Map<String, dynamic> params, Function success, Function error}) {
    _request(url, success, method: "GET", params: params, errorCallback: error);
  }

  /// post 请求
  void post(String url,
      {Map<String, dynamic> params, Function success, Function error}) async {
    _request(url, success,
        method: "POST", params: params, errorCallback: error);
  }

  /// delete 请求
  void delete(String url,
      {Map<String, dynamic> params, Function success, Function error}) async {
    _request(url, success,
        method: "DELETE", params: params, errorCallback: error);
  }

  /// patch 请求
  void patch(String url,
      {Map<String, dynamic> params, Function success, Function error}) {
    _request(url, success,
        method: "PATCH", params: params, errorCallback: error);
  }

  //具体的还要看返回数据，公共代码部分
  void _request(
    String url,
    Function callBack, {
    String method,
    Map<String, dynamic> params,
    Function errorCallback,
  }) async {
    connectionStatus = await (new Connectivity().checkConnectivity());
    //判断设备联网状态
    switch (connectionStatus) {
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.none:
        _handError(errorCallback, ResultCode.NETWORK_ERROR, "好像没有网络了~");
        return;
        break;
    }

    Response response;

    try {
      Map<String, dynamic> _data;
      Map<String, dynamic> _queryParameters;

      if (method == "POST" || method == "PATCH") {
        _data = params;
      } else {
        _queryParameters = params;
      }
      response = await _dio.request(url,
          data: _data,
          queryParameters: _queryParameters,
          cancelToken: cancelToken,
          options: new Options(method: method));
    } on DioError catch (error) {
      _handError(errorCallback, error.response.statusCode,
          jsonEncode(error.response.data));
      return;
    }

    try {
      if (response.statusCode == ResultCode.NETWORK_SUCCESS) {
        callBack(response);
      }
    } catch (error) {
      _handError(errorCallback, response.statusCode, response.data.toString());
    }
  }

  //处理异常
  void _handError(Function errorCallback, int code, String errorMsg) {
    try {
      if (errorCallback != null) {
        errorCallback(code, errorMsg);
        return;
      }
    } catch (error) {
      if (errorCallback != null) {
        errorCallback(code, errorMsg);
        return;
      }
    }
  }
}

class ResultCode {
  /// 网络错误
  static const NETWORK_ERROR = -1;

  /// 网络超时
  static const NETWORK_TIMEOUT = -2;

  /// 请求成功
  static const NETWORK_SUCCESS = 200;
  static const NETWORK_SUCCESS1 = 201;
  static const NETWORK_SUCCESS4 = 204;

  /// 登陆失效
  static const NETWORK_BAD = 400;
  static const NETWORK_INVALID = 401;
  static const NETWORK_NOTFOUND = 404;
}
