import 'package:hive/hive.dart';

part 'product_res_model.g.dart';

class ProductResModel {
  bool? error;
  List<ProductList>? productList;

  ProductResModel({this.error, this.productList});

  ProductResModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 2)
class ProductList extends HiveObject {
  @HiveField(0)
  int? tenantId;
  @HiveField(1)
  String? name;
  @HiveField(3)
  String? customCode;
  @HiveField(4)
  String? unitprice;
  @HiveField(5)
  String? msp;
  @HiveField(6)
  int? id;
  @HiveField(7)
  bool? isActive;
  @HiveField(8)
  List<int>? productOption1;
  @HiveField(11)
  String? gst;
  @HiveField(12)
  int? sp;
  @HiveField(13)
  List<ProductVariants>? productVariants;
  @HiveField(15)
  int? selectedUnit = 0;

  ProductList(
      {this.tenantId,
      this.name,
      this.customCode,
      this.unitprice,
      this.msp,
      this.id,
      this.isActive,
      this.productOption1,
      this.gst,
      this.sp,
      this.productVariants,
      this.selectedUnit = 0});

  ProductList.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenant_id'];
    name = json['name'];
    customCode = json['custom_code'];
    unitprice = json['unitprice'];
    msp = json['msp'];
    id = json['id'];
    isActive = json['is_active'];
    if (json['product_option1'] != null) {
      productOption1 = json['product_option1'].cast<int>();
    }
    gst = json['gst'];
    sp = json['sp'];
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(ProductVariants.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 3)
class ProductVariants extends HiveObject {
  @HiveField(0)
  int? productId;
  @HiveField(1)
  String? variantType;
  @HiveField(2)
  String? variantValue;
  @HiveField(3)
  int? tenantId;
  @HiveField(4)
  String? createdAt;

  ProductVariants(
      {this.productId,
      this.variantType,
      this.variantValue,
      this.tenantId,
      this.createdAt});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    variantType = json['variant_type'];
    variantValue = json['variant_value'];
    tenantId = json['tenant_id'];
    createdAt = json['created_at'];
  }
}
