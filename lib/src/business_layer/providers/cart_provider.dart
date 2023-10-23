import 'package:cartapp/src/business_layer/network/request_response_type.dart';
import 'package:cartapp/src/business_layer/providers/base_provider.dart';
import 'package:cartapp/src/business_layer/repository/cart_repository.dart';
import 'package:cartapp/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:cartapp/src/data_layer/models/base_api_res_model.dart';
import 'package:cartapp/src/data_layer/models/cart_model.dart';
import 'package:cartapp/src/data_layer/models/product/product_res_model.dart';

class CartProvider extends BaseProvider {
  final _cartRepository = CartRepository();
  ProductResModel _productResModel = ProductResModel();
  CartModel _cartModel = CartModel();
  String _colour = "";
  String _size = "";

  /// Api to get user list
  Future<String?> getProductList() async {
    if (await checkInternet()) {
      BaseApiResponseModel response = await _cartRepository.getProductList();
      if (response.data != null && response.data is ProductResModel) {
        _productResModel = response.data;
        if (_productResModel.productList != null) {
          await _fetchHiveCart();
          notifyListeners();
          return HttpResponseType.success;
        } else {
          return "Something went wrong";
        }
      } else {
        return getExceptionMessage(exceptionType: response.exceptionType);
      }
    } else {
      return "No internet";
    }
  }

  void incrementQuantity(ProductList productList) {
    productList.selectedUnit = productList.selectedUnit! + 1;
    increaseCartDetails(productList);
    notifyListeners();
  }

  void decrementQuantity(ProductList productList) {
    if (productList.selectedUnit! > 0) {
      productList.selectedUnit = productList.selectedUnit! - 1;
      decreaseCartDetails(productList);
    }
    notifyListeners();
  }

  Future<void> increaseCartDetails(ProductList productList) async {
    if (productList.selectedUnit == 1) {
      _cartModel.quantity = _cartModel.quantity! + 1;
    }
    _cartModel.totalUnits = _cartModel.totalUnits! + 1;
    _cartModel.totalPrice = _cartModel.totalPrice! + productList.sp!;
    _updateCart();
    await _fetchHiveCart();
  }

  Future<void> decreaseCartDetails(ProductList productList) async {
    if (productList.selectedUnit == 0) {
      _cartModel.quantity = _cartModel.quantity! - 1;
    }
    _cartModel.totalUnits = _cartModel.totalUnits! - 1;
    _cartModel.totalPrice = _cartModel.totalPrice! - productList.sp!;
    _updateCart();
    await _fetchHiveCart();
  }

  ///update cart in hive data base
  void _updateCart() {
    List<ProductList> cartList = [];
    for (int i = 0; i < productResModel.productList!.length; i++) {
      if (productResModel.productList![i].selectedUnit! > 0) {
        print("Added product-----${productResModel.productList![i].name}");
        cartList.add(productResModel.productList![i]);
      }
    }
    _cartModel.addedProducts = cartList;
    UserStateHiveHelper.instance.saveCart(_cartModel);
  }

  Future<void> _fetchHiveCart() async {
    cartModel = await UserStateHiveHelper.instance.getCart() ?? CartModel();
  }

  ProductResModel get productResModel => _productResModel;

  CartModel get cartModel => _cartModel;

  set cartModel(CartModel value) {
    _cartModel = value;
    notifyListeners();
  }

  String get colour => _colour;

  set colour(String value) {
    _colour = value;
    notifyListeners();
  }

  String get size => _size;

  set size(String value) {
    _size = value;
    notifyListeners();
  }
}
