// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_res_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductListAdapter extends TypeAdapter<ProductList> {
  @override
  final int typeId = 2;

  @override
  ProductList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductList(
      tenantId: fields[0] as int?,
      name: fields[1] as String?,
      customCode: fields[3] as String?,
      unitprice: fields[4] as String?,
      msp: fields[5] as String?,
      id: fields[6] as int?,
      isActive: fields[7] as bool?,
      productOption1: (fields[8] as List?)?.cast<int>(),
      gst: fields[11] as String?,
      sp: fields[12] as int?,
      productVariants: (fields[13] as List?)?.cast<ProductVariants>(),
      selectedUnit: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductList obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.tenantId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.customCode)
      ..writeByte(4)
      ..write(obj.unitprice)
      ..writeByte(5)
      ..write(obj.msp)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(8)
      ..write(obj.productOption1)
      ..writeByte(11)
      ..write(obj.gst)
      ..writeByte(12)
      ..write(obj.sp)
      ..writeByte(13)
      ..write(obj.productVariants)
      ..writeByte(15)
      ..write(obj.selectedUnit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductVariantsAdapter extends TypeAdapter<ProductVariants> {
  @override
  final int typeId = 3;

  @override
  ProductVariants read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVariants(
      productId: fields[0] as int?,
      variantType: fields[1] as String?,
      variantValue: fields[2] as String?,
      tenantId: fields[3] as int?,
      createdAt: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductVariants obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.variantType)
      ..writeByte(2)
      ..write(obj.variantValue)
      ..writeByte(3)
      ..write(obj.tenantId)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariantsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
