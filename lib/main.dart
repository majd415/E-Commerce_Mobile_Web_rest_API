import 'package:bloc/bloc.dart';
import 'package:ecommerce/layout/shop_app/cubit/cubit.dart';
import 'package:ecommerce/modules/shop_app/login/shop_login_screen.dart';
import 'package:ecommerce/modules/shop_app/on_bording/on_bording_screen.dart';
import 'package:ecommerce/shared/bloc_observer.dart';
import 'package:ecommerce/shared/network/local/cashe_helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:ecommerce/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_screen/helper_func.dart';
import 'layout/shop_app/shop_layout.dart';

import 'dart:io';

import 'modules/shop_app/firstweb_screen/first_web_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  customErrorScreen();
  Bloc.observer = MyBlocObserver();//رن للكيوبيت اوبسيرفر
  DioHelper.init();
  await CasheHelper.init();
  //DioHelper1.init();
  // DioHelper.gettestdio();
  bool? onBoarding=CasheHelper.getData(key: 'onBoarding');

  String? token=CasheHelper.getData(key: 'token');
  Widget widget;

  if(onBoarding != null){//اذا عديت من ال onboarding
  if(token!=null) widget=ShopLayout(); //وصار معك token روج على شوب لي اوت
  else widget=ShopLoginScreen();//والا روح على ال login
  }  else widget=OnBordingScreen();
  await CasheHelper.init();
  final Widget? startWidget;//here onBoarding

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;

  MyApp(
      {required this.startWidget}
      );  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(  create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()//here call method get
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: Builder(builder: (context) {

          //for just screen use the LayputBuilder
          //for screen or editing element inside the screen like width text or any style element

          // if(MediaQuery.of(context).size.width.toInt() <= 560) {
          //   return startWidget;
          // }
          // return WebScreen();
          return startWidget;
        },
        ),//startWidget,
    ),
      );
  }
}

