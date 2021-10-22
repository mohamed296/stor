import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/layout/shop_layout_screan.dart';
import 'package:stor/modules/login/login_screan_module.dart';

import 'package:stor/shared/service/local/sheardp_helper.dart';
import 'package:stor/shared/service/network/dio_helper.dart';

import 'modules/onboarding/onboarding.dart';
import 'shared/provider/bloc_observer.dart';
import 'shared/style/them_app.dart';
import 'shared/widget/constante.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SherdHelper.init();
  bool? isOnBoarding = SherdHelper.getDataFromSP(key: "onBoarding");
  token = SherdHelper.getDataFromSP(key: "Token");

  Widget startWidget;

  if (isOnBoarding != null) {
    if (token != null) {
      startWidget = const ShopLayoutScrean();
    } else {
      startWidget = LoginScreanModule();
    }
  } else {
    startWidget = const OnBoarding();
  }

  runApp(MyApp(
    startScrean: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.startScrean,
  }) : super(key: key);
  final Widget startScrean;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startScrean);
  }
}
