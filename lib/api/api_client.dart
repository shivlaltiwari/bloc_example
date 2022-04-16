
import 'package:dio/dio.dart';
import 'package:template/api/api_code.dart';
import 'package:template/api/api_constants.dart';

import 'api_error_constants.dart';
import 'dio_http.dart';
import 'ihttp.dart';
import 'result.dart';

class ApiClient {
  late IHttp iHttp;

  ApiClient() {
    iHttp = DioHttp();
  }

  Future<Result> handleError(ApiCall apiCall) async {
    try {
      var resp = await apiCall();
      return Result.success(resp.data);
    } catch (e) {
      return Result.error(_getErrorData(e));
    }
  }

  DataError _getErrorData(error) {
    String errorDescription = "";
    int errorStatusCode =
        error.response?.statusCode ?? ApiCode.UNEXPECTED_ERROR;
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = APIErrorConstants.DIO_ERROR_CANCEL;
          break;
        case DioErrorType.connectTimeout:
          errorDescription = APIErrorConstants.DIO_ERROR_CONNECT_TIMEOUT;
          break;
        case DioErrorType.other:
          if (error.message.contains('SocketException')) {
            errorStatusCode = ApiCode.NO_INTERNET_CONNECTION;
            errorDescription = APIErrorConstants.NO_INTERNET_CONNECTION;
          } else {
            errorDescription = APIErrorConstants.DIO_ERROR_DEFAULT;
          }
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = APIErrorConstants.DIO_ERROR_RECEIVE_TIMEOUT;
          break;
        case DioErrorType.response:
          if (dioError.response != null) {
            if (dioError.response!.statusCode == ApiCode.SERVER_ERROR) {
              errorDescription = dioError.response!.statusMessage!;
              break;
            } else if (dioError.response!.statusCode ==
                ApiCode.SERVICE_TEMPORALILY_UNAVAILABLE) {
              errorDescription =
                  APIErrorConstants.SERVICE_TEMPORALILY_UNAVAILABLE;
              break;
            } else if (dioError.response!.statusCode == ApiCode.UNAUTHORIZED) {
              errorDescription = APIErrorConstants.UNAUTHORIZED;
              break;
            } else if (error.response?.data['message'] != null) {
              errorDescription =
                  _getErrorResponseMessage(error.response?.data['message']);
              break;
            }
          } else {
            errorDescription = dioError.message;
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = APIErrorConstants.DIO_ERROR_SEND_TIMEOUT;
          break;
      }
    } else {
      errorDescription = APIErrorConstants.UNEXPECTED_ERROR;
    }
    return DataError(errorDescription, errorStatusCode);
  }

  String _getErrorResponseMessage(dynamic responseErrorMessage) {
    String message = '';
    if (responseErrorMessage is String) {
      return responseErrorMessage;
    } else if (responseErrorMessage is Map) {
      responseErrorMessage.forEach((key, value) {
        message = message + value[0] + '\n';
      });
      return message;
    }
    return message;
  }

  // for all feeds
  Future<Result> getDogsImage() async {
    try {
      var response =
          await handleError(() async => await iHttp.get(BaseUrl));
      return response;
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}

typedef ApiCall = Future<Response> Function();
