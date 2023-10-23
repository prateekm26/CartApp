import 'dart:convert';

import 'package:cartapp/src/business_layer/network/api_constants.dart';
import 'package:cartapp/src/business_layer/network/request_response_type.dart';
import 'package:cartapp/src/business_layer/util/helper/log_helper.dart';
import 'package:cartapp/src/data_layer/models/product/product_res_model.dart';
import 'package:http/http.dart' as http;

import '../../data_layer/models/base_api_res_model.dart';

class CartRepository {
  final String _tag = "Feed Repository: ";
  Map<String, dynamic>? _responseBody;

  Future<BaseApiResponseModel> getProductList() async {
    //try {
    final response = await http.get(Uri.parse(ApiConstants.baseUrl));

    LogHelper.logData(_tag + response.body.toString());
    if (response.body != null && response.statusCode == 200) {
      _responseBody = json.decode(response.body.toString());
      print("res#### ${_responseBody}");
      return BaseApiResponseModel(
          data: ProductResModel.fromJson(_responseBody!));
    } else {
      return BaseApiResponseModel(exceptionType: ExceptionType.apiException);
    }
    /*} catch (e) {
      LogHelper.logError(_tag + e.toString());
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }*/
  }
}
