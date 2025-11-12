import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/app_colors.dart';
import 'views/common/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryNavy,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.pureWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const IUBSocialApp());
}

class IUBSocialApp extends StatelessWidget {
  const IUBSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IUB Social',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryNavy,
        scaffoldBackgroundColor: AppColors.offWhite,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryNavy,
          primary: AppColors.primaryNavy,
          secondary: AppColors.accentNavy,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryNavy,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.pureWhite),
          titleTextStyle: TextStyle(
            color: AppColors.pureWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentNavy,
            foregroundColor: AppColors.pureWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}
