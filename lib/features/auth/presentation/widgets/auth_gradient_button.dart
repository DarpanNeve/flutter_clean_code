import 'package:flutter/material.dart';
import 'package:flutter_clean_code/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;

  const AuthGradientButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: AppPallete.kLinearGradient,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          fixedSize: Size(size.width * 0.8, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
