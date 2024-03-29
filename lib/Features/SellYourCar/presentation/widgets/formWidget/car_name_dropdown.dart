import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mowaterApp/Features/CareForSaleBrand/presentation/cubit/CarBrands/car_brands_cubit.dart';
import 'package:mowaterApp/Features/CareForSaleBrand/presentation/cubit/carModelsBrand/car_models_brands_cubit.dart';
import 'package:mowaterApp/core/constants/color.dart';
import 'package:mowaterApp/core/constants/size.dart';
import 'package:mowaterApp/core/di/dependency_injection.dart';
import 'package:mowaterApp/core/helper/reqexp.dart';
import 'package:mowaterApp/core/style/text_style.dart';
import 'package:mowaterApp/core/widgets/loading/shimmer_widget.dart';

class CarNameDropDownWidget extends StatefulWidget {
  TextEditingController carNameController;
  void Function(int?)? onChanged;
  CarNameDropDownWidget(
      {Key? key, required this.carNameController, this.onChanged})
      : super(key: key);

  @override
  State<CarNameDropDownWidget> createState() => _CarNameDropDownWidgetState();
}

class _CarNameDropDownWidgetState extends State<CarNameDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CarBrandsCubit>()..getAllBrands(),
      child: BlocBuilder<CarBrandsCubit, CarBrandsState>(
        builder: (context, state) {
          return state.when(
              initial: () => const SizedBox(),
              success: (data) => Stack(
                    children: [
                      DropdownButtonFormField<String>(
                        itemHeight: 50,
                        menuMaxHeight: 350.h,
                        isExpanded: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorApp.primeryColorDark),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorApp.primeryColorDark),
                          ),
                          prefixIcon: const Icon(Icons.directions_car_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelStyle: TextStyles.text_18
                              .copyWith(color: Colors.white, fontSize: 18.sp),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          labelText: 'Car Make',
                          labelStyle:
                              TextStyles.text_14.copyWith(fontSize: 14.sp),
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.carNameController.text = value!;
                            context
                                .read<CarModelsBrandsCubit>()
                                .getBrandModels(widget.carNameController.text);
                          });
                        },
                        value: widget.carNameController.text.isEmpty
                            ? null
                            : widget.carNameController.text,
                        items: data.map<DropdownMenuItem<String>>((brand) {
                          return DropdownMenuItem<String>(
                              onTap: () {
                                widget.onChanged?.call(brand.id);
                              },
                              value: brand.name,
                              child: Text(
                                  AppRegex.extractEnglishText(brand.name)));
                        }).toList(),
                      )
                    ],
                  ),
              faliure: (error) {
                return const Text("");
              },
              loading: () =>
                  ShimmerWidget(width: mediasize(context).width, height: 55.h));
        },
      ),
    );
  }
}
