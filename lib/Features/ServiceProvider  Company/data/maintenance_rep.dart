// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mowaterApp/Features/SellYourCar/presentation/widgets/formWidget/specifications_dropdown.dart';
// import 'package:mowaterApp/Features/ServiceProvider%20%20Company/model/service_account.dart';
// import 'package:mowaterApp/core/networking/api/api_service.dart';

// class ServiceProviderMaintenance {
//   final ApiService _apiService;
//   ServiceProviderMaintenance(this._apiService);

//   addServiceProvider(ServiceProviderAccountModel accountModel) async {
//     _apiService.addServicePrviderMaintenance(FormData.fromMap({
//       'password': accountModel.password,
//       'weekday_work': accountModel.selectedDays.join(','),
//       'start_time': formatTimeOfDay(accountModel.startTime!),
//       'end_time': formatTimeOfDay(accountModel.endTime!),
//       'specialty': specifications.,
//       'description': '',
//       'location': '',
//       'phoneNumber': '',
//       'WhatsAppNumber': '',
//       'company_image': '',
//       'carMakes': '',
//       'approval': '',
//       'latitude': '',
//       'longitude': '',
//       'name': ''
//     }));
//   }
// }

// String formatTimeOfDay(TimeOfDay timeOfDay) {
//   final now = DateTime.now();
//   final DateTime datetime =
//       DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//   return DateFormat.jm().format(datetime);
// }
