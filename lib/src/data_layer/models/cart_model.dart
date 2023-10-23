import 'package:hive/hive.dart';

import 'product/product_res_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel extends HiveObject {
  @HiveField(0)
  List<ProductList>? addedProducts;
  @HiveField(1)
  int? quantity = 0;
  @HiveField(2)
  int? totalUnits = 0;
  @HiveField(3)
  int? totalPrice = 0;
  CartModel(
      {this.addedProducts,
      this.quantity = 0,
      this.totalUnits = 0,
      this.totalPrice = 0});
}
