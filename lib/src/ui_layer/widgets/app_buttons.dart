import 'package:cartapp/src/data_layer/res/app_colors.dart';
import 'package:cartapp/src/data_layer/res/images.dart';
import 'package:cartapp/src/data_layer/res/numbers.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  bool active;
  VoidCallback? onTap;
  String label;
  CommonButton({Key? key, this.active = true, this.onTap, this.label = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height > d_750 ? d_50 : d_40,
        decoration: BoxDecoration(
            boxShadow: [
              active
                  ? BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: d_5,
                      blurRadius: d_10,
                      offset: const Offset(d_0, d_5))
                  : const BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: d_5,
                      blurRadius: d_10,
                      offset: Offset(d_0, d_5)),
            ],
            color: active ? AppColors.mainColor : deactivatButtonColor,
            borderRadius: BorderRadius.circular(d_100)),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}

class CommonBorderButton extends StatelessWidget {
  VoidCallback? onTap;
  String label;
  CommonBorderButton({Key? key, this.onTap, this.label = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: d_8, horizontal: d_20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(color: AppColors.purpleColorShade, width: d_1),
          borderRadius: BorderRadius.circular(d_20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.purpleColorShade,
            fontSize: d_13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsets? buttonPadding;
  final AlignmentGeometry? buttonAlignment;
  const CustomBackButton(
      {Key? key,
      this.onPressed,
      this.color,
      this.buttonPadding,
      this.buttonAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: buttonAlignment ?? Alignment.center,
      padding: buttonPadding ?? const EdgeInsets.all(8.0),
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: Image.asset(
        AppImages.backArrow,
        width: 24,
        height: 16,
        color: AppColors.blackColor,
      ),
    );
  }
}
