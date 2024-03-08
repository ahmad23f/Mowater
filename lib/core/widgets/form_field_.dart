import 'package:flutter/material.dart';
import 'package:mowaterApp/core/constants/color.dart';
import 'package:mowaterApp/core/style/text_style.dart';

class CustomFormFieldWitheBorder extends StatelessWidget {
  TextEditingController? textEditingController;
  String label;
  IconData iconData;
  CustomFormFieldWitheBorder(
      {super.key,
      required this.label,
      this.textEditingController,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        label: Text(
          label,
          style: TextStyles.text_14.copyWith(color: Colors.white),
        ),
        prefixIcon: Icon(iconData),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorApp.primeryColorDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:
                ColorApp.primeryColorDark, // Change border color when focused
          ),
        ),
      ),
    );
  }
}
