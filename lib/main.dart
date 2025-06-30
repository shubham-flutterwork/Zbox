import 'package:flutter/material.dart';
import 'package:zbox_admin/auth_screen/loginscreen.dart';
import 'constants/color.dart';

void main() {
  runApp(MyApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Zbox Admin',
          themeMode: mode,

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.blue,
              secondary: AppColors.red,
              surface: Colors.grey[900]!,
              onSurface: Colors.white,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: LoginScreen( themeNotifier: themeNotifier,),
        );
      },
    );
  }
}
