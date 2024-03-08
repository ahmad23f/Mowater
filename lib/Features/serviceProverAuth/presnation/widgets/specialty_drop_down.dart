import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mowaterApp/Features/serviceProverAuth/data/serviceType/service_type.dart';
import 'package:mowaterApp/core/constants/color.dart';

class SpecialtyDropDown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  String? selectedValue;

  SpecialtyDropDown({Key? key, this.onChanged, this.selectedValue})
      : super(key: key);

  @override
  _SpecialtyDropDownState createState() => _SpecialtyDropDownState();
}

class _SpecialtyDropDownState extends State<SpecialtyDropDown> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField2<String>(
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorApp.secunderyColorDark,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            hint: const Text(
              'Service specialty',
              style: TextStyle(fontSize: 14),
            ),
            value: widget.selectedValue, // Setting the initial value
            items: serviceProviderType
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select service specialty.';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                widget.selectedValue = value; // Update selected value
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 30.dg,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }
}
