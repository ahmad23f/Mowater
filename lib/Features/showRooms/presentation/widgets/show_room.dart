import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mowaterApp/Features/CareForSaleBrand/presentation/widgets/contact_whats_and_call.dart';
import 'package:mowaterApp/Features/showRooms/models/show_room.dart';
import 'package:mowaterApp/core/constants/color.dart';
import 'package:mowaterApp/core/constants/size.dart';
import 'package:mowaterApp/core/style/text_style.dart';

class ShowRoomWidget extends StatelessWidget {
  ShowroomModel showroomModel;
  ShowRoomWidget({super.key, required this.showroomModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorApp.secunderyColorDark,
          borderRadius: BorderRadius.circular(12)),
      height: 298.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: showroomModel.showRommImage,
              fit: BoxFit.cover,
              width: mediasize(context).width,
              height: 160.h,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      showroomModel.name,
                      style: TextStyles.text_14.copyWith(fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          size: 20.dg,
                          color: ColorApp.primeryColorDark,
                        ),
                        Text(
                          showroomModel.location,
                          style: TextStyles.text_14.copyWith(
                            fontSize: 14.sp,
                            color: ColorApp.primeryColorDark,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                verticalSpace(6.dg),
                Row(
                  children: [
                    const Icon(Icons.construction_sharp),
                    horizontalSpace(5.w),
                    Text(
                      toBeginningOfSentenceCase(
                            showroomModel.specifications,
                          ) ??
                          '',
                      style: TextStyles.text_12.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                verticalSpace(6.dg),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded),
                    horizontalSpace(5.w),
                    Text(
                      showroomModel.startTime ?? '',
                      style: TextStyles.text_12.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      " - ${showroomModel.endTime}",
                      style: TextStyles.text_12.copyWith(
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.w,
            ),
            child: ContactWhatsAndCall(
              callNumber: showroomModel.callNumber.toString(),
              whatsAppNumber: showroomModel.whatsAppNumber.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
