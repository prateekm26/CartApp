import 'package:cartapp/src/data_layer/res/app_colors.dart';
import 'package:flutter/material.dart';

class MessageHelper {
  /// Method used to show error messages
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      backgroundColor: AppColors.mainColor,
    ));
  }
}
