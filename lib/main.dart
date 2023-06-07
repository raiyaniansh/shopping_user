import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseecom/screen/bottom/view/bottom_screen.dart';
import 'package:firebaseecom/screen/detail/view/detail_screen.dart';
import 'package:firebaseecom/screen/search/view/search_screen.dart';
import 'package:firebaseecom/screen/singin/view/singin_screen.dart';
import 'package:firebaseecom/screen/singup/view/signup_screen.dart';
import 'package:firebaseecom/screen/splash/view/splash_screen.dart';
import 'package:firebaseecom/screen/user/view/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
      Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(name: '/', page: () => SplashScreen(),transition: Transition.fadeIn),
            GetPage(name: '/login', page: () => SingInscreen(),transition: Transition.fadeIn),
            GetPage(name: '/singup', page: () => SingUpscreen(),transition: Transition.fadeIn),
            GetPage(name: '/bottom', page: () => BottomScreen(),transition: Transition.fadeIn),
            GetPage(name: '/details', page: () => DetialScreen(),transition: Transition.fadeIn),
            GetPage(name: '/user', page: () => UserScreen(),transition: Transition.fadeIn),
            GetPage(name: '/search', page: () => SearchScreen(),transition: Transition.fadeIn),
          ],
        ),
      )
  );
}