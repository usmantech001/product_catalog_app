import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_catalog_app/dep/init.dart' as dep;
import 'package:product_catalog_app/presentation/screens/home_screen.dart';
import 'package:product_catalog_app/utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        title: 'PRODUCT_CATALOG_APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:const AppBarTheme(
            backgroundColor: AppColors.white,
            centerTitle: true,
            scrolledUnderElevation: 0
          ),
          scaffoldBackgroundColor: AppColors.white,
         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
