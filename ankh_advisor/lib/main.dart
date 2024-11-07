import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/themes/themes.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:ankh_advisor/pages/home_page.dart';
import 'package:ankh_advisor/pages/onboarding_page.dart';
import 'package:ankh_advisor/serves/bloc_observer.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget? startWidget;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  runApp(const MyApp());


  ACCESSTOKEN = await CacheHelper.getData(key:'token')??'';
  print('Token : $ACCESSTOKEN');
  bool onBoarding = CacheHelper.getData(key: 'OnBoarding')??false;

  if(onBoarding)
    {
      startWidget = HomePage();
    }
  else{
    startWidget = const OnBoardingScreen();
    }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeLandMarksCubit()..getMostRecentLandMarks()..getRecommendedLandMarks()..getLikes(ACCESSTOKEN)..getUrl(),
        ),
      ],
      child: BlocConsumer<HomeLandMarksCubit, LandMarksStates>(
          listener: (context, state) {},
          builder: (context, state) {
            bool isDark = CacheHelper.getData(key:'isDark')?? true;
            defaultColor = Color(CacheHelper.getData(key: 'color')?? Colors.orange.value) ;// CacheHelper.getData(key: 'color')?? Colors.red;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme,
              theme: lightTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}
