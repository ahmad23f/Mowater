import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mowaterApp/Features/Parking/presentation/widgets/add_new_plate_widget.dart';
import 'package:mowaterApp/Features/SellYourCar/presentation/widgets/formWidget/location_dropdown.dart';
import 'package:mowaterApp/Features/SellYourCar/presentation/widgets/formWidget/price_form_filed.dart';
import 'package:mowaterApp/Features/carNumbers/models/plate_model.dart';
import 'package:mowaterApp/Features/carNumbers/presntation/sellYourPlate/sell_you_plate_cubit.dart';
import 'package:mowaterApp/core/constants/color.dart';
import 'package:mowaterApp/core/style/text_style.dart';
import 'package:mowaterApp/core/widgets/button.dart';
import 'package:mowaterApp/core/widgets/custom_text_field.dart';
import 'package:mowaterApp/core/widgets/snak_bar.dart';
import 'package:mowaterApp/core/widgets/text_form_fiedl.dart';

class SellYourPlateScreen extends StatefulWidget {
  const SellYourPlateScreen({super.key});

  @override
  State<SellYourPlateScreen> createState() => _SellYourPlateScreenState();
}

TextEditingController plateNumber = TextEditingController();
TextEditingController owner = TextEditingController();
TextEditingController whatsApp = TextEditingController();
TextEditingController phoneNumber = TextEditingController();
TextEditingController price = TextEditingController();
String selectedSource = 'Abu Dhabi';
String code = '';
bool isNegotiable = false;

class _SellYourPlateScreenState extends State<SellYourPlateScreen> {
  void _submitForm() async {
    if (plateNumber.text.isEmpty ||
        owner.text.isEmpty ||
        whatsApp.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        price.text.isEmpty ||
        selectedSource.isEmpty) {
      ShowSnakBar(
        context,
        title: 'Failure',
        iconData: Icons.info_outline_rounded,
        messageTextStyle:
            TextStyles.text_16.copyWith(fontWeight: FontWeight.bold),
        content: 'Please fill in all fields.',
        subtitleTextStyle: TextStyles.text_16,
        backGroundColor: ColorApp.secunderyColorDark,
      );
      return;
    } else {
      await context.read<SellYouPlateCubit>().sellYourPlate(
            PlateModelForSale(
              isApproved: 0,
              id: 0,
              source: selectedSource,
              code: code,
              owner: owner.text,
              whatsApp: whatsApp.text,
              phoneNmber: phoneNumber.text,
              price: price.text,
              postAt: DateTime.now(),
              isNegotiable: isNegotiable == true ? 1 : 0,
              plateNumber: plateNumber.text,
            ),
            context,
          );

      // Clear all the variables after submitting the form
      setState(() {
        plateNumber.clear();
        owner.clear();
        whatsApp.clear();
        phoneNumber.clear();
        price.clear();
        selectedSource = 'Abu Dhabi'; // or any default value you want to set
        code = '';
        isNegotiable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sell Your Plate',
          style: TextStyles.text_16,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.dg),
          child: Column(
            children: [
              BuildAddPlateWidget(
                plateNumberController: plateNumber,
                selectedValue: selectedSource,
                onPlateCodeChanged: (p0) {
                  code = p0!;
                },
              ), // Us
              CustomTextField2(
                  controller: owner,
                  onChanged: (p0) {
                    owner.text = p0;
                  },
                  label: 'Owner'),
              CustomTextField2(
                  controller: whatsApp,
                  textInputType: TextInputType.number,
                  onChanged: (p0) {
                    whatsApp.text = p0;
                  },
                  label: 'WhatsApp'),
              CustomTextField2(
                  textInputType: TextInputType.number,
                  controller: phoneNumber,
                  onChanged: (p0) {
                    phoneNumber.text = p0;
                  },
                  label: 'Phone Number'),
              PriceFormField(
                  controller: price,
                  onChanged: (p0) {
                    setState(() {
                      price.text = p0;
                    });
                  }),
              Row(
                children: [
                  Checkbox(
                    activeColor: ColorApp.primeryColorDark,
                    checkColor: Colors.white,
                    value: isNegotiable,
                    onChanged: (value) {
                      setState(() {
                        isNegotiable = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Negotiable',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              CustomButton(
                onPressed: _submitForm,
                padding:
                    EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
                text: 'Submit',
                color: ColorApp.primeryColorDark,
                textStyle: TextStyles.text_18
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
