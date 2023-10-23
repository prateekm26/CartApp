import 'package:cartapp/src/data_layer/res/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreenMainWidget extends StatelessWidget {
  const SplashScreenMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Cart App",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.whiteColor, fontStyle: FontStyle.italic),
                )
              ]),
        ),
      ),
    );
  }
}
