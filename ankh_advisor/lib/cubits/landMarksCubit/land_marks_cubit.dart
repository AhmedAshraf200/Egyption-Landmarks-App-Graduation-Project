import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/models/home_data_model.dart';
import 'package:ankh_advisor/models/land_marks_model.dart';
import 'package:ankh_advisor/serves/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'landMarksStates.dart';

class HomeLandMarksCubit extends Cubit<LandMarksStates> {
  HomeLandMarksCubit() : super(LandMarksInitialStates());

  static HomeLandMarksCubit get(context) => BlocProvider.of(context);

  HomeLandMarksModel? mstRecentLandMarksModel;
  void getMostRecentLandMarks() {
    emit(HomeLandMarksLoadingStates());
    fetchMostRecentData()
        .then((value)
    {
      mstRecentLandMarksModel = value;
        emit(HomeLandMarksSuccessStates());
    }).catchError((error)
    {
      emit(HomeLandMarksErrorStates());
      print(error.toString());
    });
  }



  HomeLandMarksModel? recommendedLandMarksModel;
  void getRecommendedLandMarks() {
    emit(HomeLandMarksLoadingStates());
    fetchRecommendedData()
        .then((value)
    {
      recommendedLandMarksModel = value;
        emit(HomeLandMarksSuccessStates());
    }).catchError((error)
    {
      emit(HomeLandMarksErrorStates());
      print(error.toString());
    });
  }








  LandMarksModel?  landMarksModel;
  void getLandMarkData({required String endPoint,required String id}) {
    emit(LandMarksLoadingStates());
    fetchData(endPoint: endPoint, id: id)
        .then((value)
    {
      landMarksModel = value;
        emit(LandMarksSuccessStates());
    }).catchError((error)
    {
      emit(LandMarksErrorStates());
      print(error.toString());
    });
  }



  bool isDark = false;
  ThemeMode mode = ThemeMode.light;
  void changeThemeMode()
  {
    isDark = !isDark;
    if(isDark) {
      mode = ThemeMode.dark;
      emit(ChangeThemeToLight());
    }
    else{
      mode = ThemeMode.light;
      emit(ChangeThemeToDark());
    }
  }


  void changeColorTheme(MaterialColor color)
  {
    defaultColor = color;
    emit(ChangeColorTheme());
  }

}
