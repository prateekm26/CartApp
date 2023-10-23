import 'dart:convert';
import 'dart:io';

import 'package:cartapp/src/data_layer/models/cart_model.dart';
import 'package:cartapp/src/data_layer/models/product/product_res_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../business_layer/util/helper/log_helper.dart';

class HiveHelper {
  static Future<bool> initializeHiveAndRegisterAdapters() async {
    /// Do not edit this method until you need a new adapter
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String dbFilePath = [appDocDir.path, 'cartapp_db'].join('/');
      Hive.init(dbFilePath);

      /// For every model that needs to be saved locally, an adapter is generated
      /// These adapter need to be registered
      Hive.registerAdapter(CartModelAdapter());
      Hive.registerAdapter(ProductListAdapter());
      Hive.registerAdapter(ProductVariantsAdapter());
      return true;
    } catch (e) {
      return false;
    }
  }
}

class SecureStorageHelper {
  SecureStorageHelper.__internal();

  static final SecureStorageHelper _instance = SecureStorageHelper.__internal();

  static SecureStorageHelper get instance => _instance;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String _secureKey = 'secure_key';

  String? encryptionKey;
  List<int> decodedKey = [];

  /// Method used to secure decoded key for encrypting the box [Boxes.userBox][Boxes.cartBox]
  Future<void> generateEncryptionKey() async {
    try {
      /// Decrypts and returns the value for the given key or null if key is not
      /// in the storage
      encryptionKey = await secureStorage.read(key: _secureKey);
      if (encryptionKey == null) {
        /// Generates a secure encryption key using the fortuna random algorithm
        final key = Hive.generateSecureKey();

        /// Encrypts and saves the key with the given value.
        /// If the key was already in the storage, its associated value is changed.
        /// If the value is null, deletes associated value for the given key.
        /// key shouldn't be null
        await secureStorage.write(
          key: _secureKey,
          value: base64UrlEncode(key),
        );

        /// Decrypts and returns the value for the given key
        encryptionKey = await secureStorage.read(key: _secureKey);
      }
      // /The input is decoded as if by [decoder.convert]
      decodedKey = base64Url.decode(encryptionKey!);
      LogHelper.logData('Encryption key: ========> $decodedKey');
    } catch (e) {
      LogHelper.logError("Secure Storage Exception: ========> $e");
    }
  }
}

class UserStateKeys {
  static const String cartData = 'cart_data';

  static const String languageCode = 'language_code';
  static const String languageCountryCode = 'language_country_code';
}

class Boxes {
  static const String cartBox = 'cart_box';
}

class HiveTypes {
  static const int user = 0;
}
