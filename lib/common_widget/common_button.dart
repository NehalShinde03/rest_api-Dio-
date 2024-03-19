import 'package:dio_api/common_widget/common_text.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {

  final String? buttonText;
  final VoidCallback? onPressed;

  const CommonButton({super.key, this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: CommonText(text: buttonText),
    );
  }
}
