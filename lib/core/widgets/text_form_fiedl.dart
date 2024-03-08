import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String? label;
  final TextEditingController controller;
  String? Function(String?)? validator;
  bool? isNumber = false;
  TextInputType? inputType = TextInputType.text;
  bool? isPrice = false;
  bool isPasswordField =
      false; // Allow the user to control if it's a password field
  Widget? leading;
  Widget? trailing;

  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isNumber,
    this.inputType,
    this.leading,
    this.isPrice,
    this.trailing,
    this.isPasswordField = false,
    this.label, // Default to not being a password field
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
        child: TextFormField(
          obscureText: _isObscured && widget.isPasswordField,
          style: const TextStyle(color: Colors.white),
          inputFormatters: widget.isNumber == true
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          keyboardType: widget.inputType,
          validator: widget.validator,
          controller: widget.controller,
          decoration: InputDecoration(
            suffix: widget.trailing,
            prefixIcon: widget.leading,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: const Color.fromARGB(166, 97, 97, 97),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    icon: _isObscured
                        ? const Icon(Icons.visibility, color: Colors.grey)
                        : const Icon(Icons.visibility_off, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null,
          ),
          onChanged: (_) {
            setState(() {});
          },
        ),
      ),
    );
  }
}
