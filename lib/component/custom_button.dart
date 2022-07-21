import 'package:flutter/material.dart';

import '../utils/font_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,required this.btnTxt,required this.onPress}) : super(key: key);
  final String btnTxt;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 44,
      child: ElevatedButton(
        onPressed: onPress,
        child:  Text(btnTxt,
            style: btnTextStyle),
      ),
    );
  }
}
