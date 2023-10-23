import 'package:cartapp/src/business_layer/network/request_response_type.dart';

class BaseApiResponseModel {
  BaseApiResponseModel({
    this.exceptionType = ExceptionType.noException,
    this.data,
  });

  ExceptionType exceptionType;
  dynamic data;
}

class ApiResponseModel<T> {
  ApiResponseModel({
    this.success,
    this.message,
    this.result,
    this.exceptionType = ExceptionType.noException,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) create,
  ) {
    return ApiResponseModel<T>(
      success: json['success'],
      message: json['message'],
      result: create(json['result']),
    );
  }

  bool? success;
  String? message;
  T? result;
  ExceptionType exceptionType;
}

class EmptyDataResponseModel {
  EmptyDataResponseModel();

  EmptyDataResponseModel.fromJson(Map<String, dynamic> json);
}
