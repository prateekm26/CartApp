import 'package:cartapp/src/business_layer/providers/cart_provider.dart';
import 'package:cartapp/src/data_layer/models/product/product_res_model.dart';
import 'package:cartapp/src/data_layer/res/app_colors.dart';
import 'package:cartapp/src/data_layer/res/images.dart';
import 'package:cartapp/src/ui_layer/screens/Home/cart_summary.dart';
import 'package:cartapp/src/ui_layer/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  late CartProvider _cartProvider;
  @override
  void initState() {
    super.initState();
  }

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
          "Cart List",
          style: TextStyle(color: AppColors.blackColor),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [_productListView(), _buyButton()],
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
    return Card(
      color: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 0.5, // Adjust the elevation for shadow effect
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productList.name ?? ""),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("₹${productList.unitprice ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Sale Price ₹${productList.sp ?? ""}",
                      style: const TextStyle(color: AppColors.purpleColorShade),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text("Quantity ${productList.selectedUnit}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Total Price ₹${productList.selectedUnit! * productList.sp!}",
                      style: const TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            ///product varient
            if (productList.productVariants != null &&
                productList.productVariants!.isNotEmpty)
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  CommonBorderButton(
                      onTap: () => _openBottomSheet(
                          context, productList.productVariants),
                      label: "Select Variants"),
                  if (_cartProvider.colour.isNotEmpty)
                    CommonBorderButton(
                        onTap: () => _openBottomSheet(
                            context, productList.productVariants),
                        label: "${_cartProvider.colour}"),
                  if (_cartProvider.size.isNotEmpty)
                    CommonBorderButton(
                        onTap: () => _openBottomSheet(
                            context, productList.productVariants),
                        label: "${_cartProvider.size}")
                ],
              )
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(
      BuildContext context, List<ProductVariants>? productVariants,
      {bool colour = true}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200, // Adjust the height as needed
          color: Colors.white,
          child: Center(
            child: Wrap(
              spacing: 10,
              children: List.generate(
                  productVariants?.length ?? 0,
                  (index) => CommonBorderButton(
                      onTap: () {
                        if (productVariants[index].variantType == "color") {
                          _cartProvider.colour =
                              productVariants[index].variantValue ?? "";
                        } else {
                          _cartProvider.size =
                              productVariants[index].variantValue ?? "";
                        }
                      },
                      label: "${productVariants![index].variantValue}")),
            ),
          ),
        );
      },
    );
  }

  _buyButton() {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10, top: 10),
        child: CommonButton(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartSummary())),
          label: "Buy",
        ),
      ),
    );
  }
}
