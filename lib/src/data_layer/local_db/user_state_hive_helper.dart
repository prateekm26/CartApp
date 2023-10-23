import 'dart:ui';

import 'package:cartapp/src/business_layer/util/helper/log_helper.dart';
import 'package:cartapp/src/data_layer/models/cart_model.dart';
import 'package:cartapp/src/data_layer/res/strings.dart';
import 'package:hive/hive.dart';

import 'hive_database_helper.dart';

/// Helper class to save user information locally on the device
class UserStateHiveHelper {
  UserStateHiveHelper.__internal();

  static final UserStateHiveHelper _instance = UserStateHiveHelper.__internal();

  static UserStateHiveHelper get instance => _instance;

  /// Method used to open cart box [Boxes.cartBox]
  /// Box is opened only when hive is initialized
  /// Hive already initialized in [main.dart] file
  /// inside main method before [runApp] method is called
  Future<Box<dynamic>> _openHiveBox() async {
    try {
      return await Hive.openBox(
        Boxes.cartBox,
        encryptionCipher:
            HiveAesCipher(SecureStorageHelper.instance.decodedKey),
      );
    } catch (e) {
      /// If hive db gives some error then it is initialized and open again
      /// and generate again encryption key for encrypted hive box
      await HiveHelper.initializeHiveAndRegisterAdapters();
      await SecureStorageHelper.instance.generateEncryptionKey();
      return await Hive.openBox(
        Boxes.cartBox,
        encryptionCipher:
            HiveAesCipher(SecureStorageHelper.instance.decodedKey),
      );
    }
  }

  /// Method used to close hive box [Boxes.cartBox]
  Future<void> close() async {
    _openHiveBox().then((box) {
      box.close();
    });
  }

  /// Method used to save cart data inside the box [Boxes.cartBox]
  Future<void> saveCart(CartModel? cart) async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.cartData, cart);
    LogHelper.logData("#######cart updated");
  }

  /// Method used to get cart data from the box [Boxes.cartBox]
  Future<CartModel?> getCart() async {
    CartModel? cart;
    try {
      final Box<dynamic> encryptedBox = await _openHiveBox();
      cart = encryptedBox.get(UserStateKeys.cartData);
    } catch (e) {
      LogHelper.logData("Error while fetching cart data from cache ====> $e");
    }
    return cart;
  }

  /// Method used to check user is logged in or not from the box [Boxes.cartBox]
  Future<void> setLocale(Locale locale) async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.languageCode, locale.languageCode);
    encryptedBox.put(UserStateKeys.languageCountryCode, locale.countryCode);
  }

  /// Method used to logout and delete data from the box [Boxes.cartBox]
  Future<Locale> getLocale() async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    final languageCode = encryptedBox.get(UserStateKeys.languageCode);
    final languageCountryCode =
        encryptedBox.get(UserStateKeys.languageCountryCode);
    return Locale(
      languageCode ?? LanguageConstants.englishLanguageCode,
      languageCountryCode ?? LanguageConstants.englishCountryCode,
    );
  }
}
