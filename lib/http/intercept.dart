import 'package:dio/dio.dart';
import 'package:kj/components/toast/base_toast.dart';
import 'package:kj/routes/navigator_utils.dart';
import 'package:kj/utils/save_date_tool.dart';

import 'api.dart';
import 'http.dart';

///拦截器 服务器错误信息，
///token配置
class TokenIntercept extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var headers = Map<String, String>();
    if (SaveDataTool().token?.isNotEmpty ?? false) {
      headers['Authorization'] = SaveDataTool().getFormatToken();
      headers["Content-Type"] = HttpConfig.CONTENT_TYPE;
      options.headers.addAll(headers);
    }
    handler.next(options);
  }
}

class AdapterInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == ResultCode.NETWORK_SUCCESS ||
        response.statusCode == ResultCode.NETWORK_SUCCESS1 ||
        response.statusCode == ResultCode.NETWORK_SUCCESS4) {
      response.statusCode = ResultCode.NETWORK_SUCCESS;
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    dynamic _data = err.response.data;
    //根据后端返回消息体可灵活修改
    String _detail = err.response.data["detail"];

    switch (err.response.statusCode) {
      case ResultCode.NETWORK_INVALID:
        SaveDataTool().logout();
        NavigatorUtils.toLogin();
        break;
    }
    BaseToast.show(_detail ?? _data);
    handler.next(err);
  }
}
