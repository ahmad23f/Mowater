import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mowaterApp/core/constants/color.dart';
import 'package:mowaterApp/core/constants/size.dart';
import 'package:mowaterApp/core/routing/routing_name.dart';
import 'package:mowaterApp/core/style/text_style.dart';

class ChoseAccountTypeButtons extends StatelessWidget {
  const ChoseAccountTypeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: mediasize(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
          colors: [
            ColorApp.categoryColorDark.withOpacity(0.96),
            ColorApp.categoryColorDark.withOpacity(0.1), // Black
          ],
          stops: const [0.8, 1],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Container(
            child: Text(
              textAlign: TextAlign.center,
              "Now The World Of Cars  You Are In One Place And Always Under Control",
              style: TextStyles.text_14,
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          InkWell(
            onTap: () {
              context.push(RouteName.loginUserScreen);
            },
            child: Padding(
              padding: const EdgeInsets.all(mainPadding),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorApp.primeryColorDark,
                    borderRadius: BorderRadius.circular(12)),
                width: mediasize(context).width,
                height: 50.h,
                child: Center(
                    child: Text(
                  "Personal",
                  style: TextStyles.text_18
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.push(RouteName.serviceProviderChoseTypeAccountScreen);
            },
            child: Padding(
              padding: const EdgeInsets.all(mainPadding),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorApp.primeryColorDark)),
                width: mediasize(context).width,
                height: 50.h,
                child: Center(
                    child: Text(
                  "Service Provider",
                  style: TextStyles.text_18.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.primeryColorDark),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
