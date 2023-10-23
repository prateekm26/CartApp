import 'package:cartapp/src/business_layer/providers/cart_provider.dart';
import 'package:cartapp/src/data_layer/models/product/product_res_model.dart';
import 'package:cartapp/src/data_layer/res/app_colors.dart';
import 'package:cartapp/src/ui_layer/screens/Home/cart_list_screen.dart';
import 'package:cartapp/src/ui_layer/widgets/app_buttons.dart';
import 'package:cartapp/src/ui_layer/widgets/progress_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CartProvider _cartProvider;
/*  int quantity = 0;
  int units = 0;
  int price = 0;*/

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      fetchProductList();
    });
  }

  void fetchProductList() async {
    Loader.display();
    await _cartProvider.getProductList();
    Loader.close();
  }

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(color: AppColors.blackColor),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        if (_cartProvider.cartModel.quantity! > 0) _selectedQuantityPrice(),
        _productListView()
      ],
    );
  }

  _productListView() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
            _cartProvider.productResModel.productList?.length ?? 0,
            (index) => _productView(
                _cartProvider.productResModel.productList![index])),
      ),
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
        child: Row(
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
            getItem(productList) != null &&
                    getItem(productList)!.selectedUnit! <= 0
                ? SizedBox(
                    width: 120,
                    height: 35,
                    child: CommonButton(
                      onTap: () => _cartProvider.incrementQuantity(productList),
                      label: "Add",
                    ),
                  )
                : _quantityControl(getItem(productList)!)
          ],
        ),
      ),
    );
  }

  _quantityControl(ProductList productList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => _cartProvider.decrementQuantity(productList),
              iconSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          "${getItem(productList)?.selectedUnit ?? 0}",
          style: TextStyle(fontSize: 24),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _cartProvider.incrementQuantity(productList),
              iconSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _selectedQuantityPrice() {
    return Card(
      color: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 5, // Adjust the elevation for shadow effect
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Selected Products ${_cartProvider.cartModel.quantity}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Total items ${_cartProvider.cartModel.totalUnits}"),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Total Price ₹${_cartProvider.cartModel.totalPrice}",
                  style: const TextStyle(color: AppColors.purpleColorShade),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 120,
                  child: CommonButton(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartListScreen())),
                    label: "View Cart",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ProductList? getItem(ProductList productList) {
    /*   if (_cartProvider.cartModel.addedProducts != null &&
        _cartProvider.cartModel.addedProducts!.isNotEmpty) {
      ProductList product =
          _cartProvider.cartModel.addedProducts!.firstWhere((element) {
        print(" cart element-${element.name}");
        print(" product-${productList.name}");
        return element.name == productList.name;
      });
      return product;
    }*/
    return productList;
  }
}
