import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mowaterApp/Features/Parking/models/plate_model.dart';
import 'package:mowaterApp/core/di/dependency_injection.dart';
import 'package:mowaterApp/core/routing/routing.dart';
import 'package:mowaterApp/core/services/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  Hive.registerAdapter(PlateModelAdapter());

  await setupServices();

  runApp(ScreenUtilInit(
    designSize: const Size(375, 876),
    child: MaterialApp.router(
      routerConfig: RoutingApp.router,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
