import 'package:cartapp/src/business_layer/providers/cart_provider.dart';
import 'package:cartapp/src/data_layer/models/product/product_res_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data_layer/res/app_colors.dart';
import '../../../data_layer/res/images.dart';

class CartSummary extends StatefulWidget {
  const CartSummary({Key? key}) : super(key: key);

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  late CartProvider _cartProvider;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImages.backArrow),
          ),
        ),
        title: const Text(
          "Summary",
          style: TextStyle(color: AppColors.blackColor),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        _productListView(),
        Text(
          "Total ₹${_cartProvider.cartModel.totalPrice}",
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  _productListView() {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
          _cartProvider.cartModel.addedProducts?.length ?? 0,
          (index) =>
              _productView(_cartProvider.cartModel.addedProducts![index])),
    );
  }

  _productView(ProductList productList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("${productList.name}"),
                    Text("Qt. ${productList.selectedUnit}"),
                  ],
                ),
                Text("₹${productList.sp! * productList.selectedUnit!}",
                    style: const TextStyle(color: AppColors.purpleColorShade)),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
