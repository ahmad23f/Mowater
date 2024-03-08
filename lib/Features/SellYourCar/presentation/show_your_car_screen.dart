import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mowaterApp/Features/SellYourCar/data/cubit/cubit/show_your_car_cubit.dart';
import 'package:mowaterApp/Features/SellYourCar/presentation/new_car_form.dart';
import 'package:mowaterApp/core/constants/size.dart';
import 'package:mowaterApp/core/di/dependency_injection.dart';
import 'package:mowaterApp/core/services/user_state.dart';
import 'package:mowaterApp/core/style/text_style.dart';
import 'package:mowaterApp/core/widgets/annymous_block.dart';

class SellYourCarScreen extends StatelessWidget {
  const SellYourCarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Show Your Car',
              style: TextStyles.text_22.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: UserServices.getUserInformation().id != -1
              ? BlocProvider(
                  create: (context) => getIt<SellYourCarCubti>(),
                  child: const Padding(
                    padding: EdgeInsets.all(mainPadding),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [NewCarForm()],
                      ),
                    ),
                  ),
                )
              : AnnymousNotAllowedWidget(
                  text: "you can't add car without login",
                )),
    );
  }
}
