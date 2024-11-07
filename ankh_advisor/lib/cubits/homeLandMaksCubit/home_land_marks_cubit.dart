import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:ankh_advisor/models/fliter_model.dart';
import 'package:ankh_advisor/models/home_data_model.dart';
import 'package:ankh_advisor/models/land_marks_model.dart';
import 'package:ankh_advisor/models/reviews_model.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:ankh_advisor/serves/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeLandMarksCubit extends Cubit<LandMarksStates> {
  HomeLandMarksCubit() : super(LandMarksInitialStates());

  static HomeLandMarksCubit get(context) => BlocProvider.of(context);

  HomeLandMarksModel? mostRecentLandMarksModel;
  void getMostRecentLandMarks() {
    emit(HomeLandMarksLoadingStates());
    fetchMostRecentData()
        .then((value)
    {
      mostRecentLandMarksModel = value;
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



 void getUrl()
 {
   getModelUrl().then((value)
   {
     emit(GetModelUrlSuccessStates());
   }).catchError((error)
   {
     emit(GetModelUrlErrorStates());
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

  List<CityModel>? cityList;
  void getCityFilter({required String endPoint}) {
   // emit(GetFilterLoadingStates());
    fetchFilter(endPoint: endPoint)
        .then((value)
    {
      cityList = value;
      // cityList!.forEach((city) {
      //   print('City: ${city.name}, Created At: ${city.createdAt}, Updated At: ${city.updatedAt}');
      // });
     // emit(GetFilterSuccessStates());
    }).catchError((error)
    {
      emit(GetFilterErrorStates());
      print(error.toString());
    });
  }

  List<CityModel>? tagList;
  void getTagFilter({required String endPoint}) {
    emit(GetFilterLoadingStates());
    fetchFilter(endPoint: endPoint)
        .then((value)
    {
      tagList = value;
      // tagList!.forEach((city) {
      //   print('City: ${city.name}, Created At: ${city.createdAt}, Updated At: ${city.updatedAt}');
      // });
      emit(GetFilterSuccessStates());
    }).catchError((error)
    {
      emit(GetFilterErrorStates());
      print(error.toString());
    });
  }



  HomeLandMarksModel? resultFilterModel;
  void getResultFilter(String endPoint,String id)
  {
    emit(GetResultFilterLoadingState());
    fetchResultFilter(endPoint: endPoint,id: id).then(
            (value){
          resultFilterModel = value;
          print(value);
          emit(GetResultFilterSuccessState());
        }).catchError((error)
    {
      print(error.toString());
      emit(GetResultFilterErrorState());
    });
  }




  bool isDark = true;
  //ThemeMode mode = ThemeMode.dark;
  void changeThemeMode()
  {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark);
    if(isDark) {
      //mode = ThemeMode.dark;
      emit(ChangeThemeToDark());
    }
    else{
      //mode = ThemeMode.light;
      emit(ChangeThemeToLight());
    }
  }


  void changeColorTheme(MaterialColor color)
  {
    defaultColor = color;
    CacheHelper.saveData(key: 'color', value: color.value);
    emit(ChangeColorTheme());
  }


  void clearSearch(){
    emit(ClearSearchState());
  }

  HomeLandMarksModel? homelandModelSearch;
  void getSearchData(String searchValue)
  {
    emit(GETSearchStateLoadingStates());
    getSearch(searchValue).then((value)
    {
      homelandModelSearch = value;
      emit(GETSearchStateSuccessStates());
    }).catchError((error)
    {
      emit(GETSearchStateErrorStates());
      print(error.toString());
    });
  }

  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  void playAudio(String text) async
  {
    isSpeaking = !isSpeaking;
    if (isSpeaking) {
      emit(ChangeSpeakIcon());
      await flutterTts.setLanguage('en-us');
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }
    else
    {
      isSpeaking = false;
      emit(ChangeSpeakIcon());
      await flutterTts.stop();
    }
  }


  void likeLandMark(String id, String token)
  {
    emit(LikeLoadingStates());
    toggleLike(id: id,token: token).then(
            (value)
        {
          emit(LikeSuccessStates());
          print(value.toString());
        }).catchError((error)
    {
      emit(LikeErrorStates());
    print(error.toString());
    });
  }

  List<dynamic> likes = [];
  void getLikes(String token)
  {
    if(ACCESSTOKEN.isNotEmpty) {
      emit(GetLikeLoadingStates());
      getAllLikes( token: token).then(
            (value)
        {
          likes = value;
          print("likes is :${likes.toString()}");
          emit(GetLikeSuccessStates());
        }).catchError((error)
    {
      emit(GetLikeErrorStates());
    });
    }
  }

 void signOut()
 {
   CacheHelper.removerData(key: 'token').then(
           (value)
       {
         print(value.toString());
         emit(SignOutSuccessStates());
       }).catchError(
           (error)
       {
         print(error);
         emit(SignOutErrorStates());
       });
 }

 bool isOut = ACCESSTOKEN.isEmpty;
 void isUserOut()
 {
   if(CacheHelper.getData(key: 'token') != null)
     {
       isOut = false;
       emit(CheckUserInState());
     }
   else{
     isOut = true;
     emit(CheckUserOutState());
   }
 }

  int rating = 0;
  int starsIndex = 0;
  Widget buildStar(int index) {

    return IconButton(
      icon: Icon(
        size: 40,
        Icons.star,
        color: index < rating ? Colors.yellow : Colors.grey,
      ),
      onPressed: () {
        rating = index + 1;
        emit(ReviewStarsStates());
        starsIndex = index+1;
        print(starsIndex);
      },
    );
  }


  Widget getStar(int index) {
    return const Icon(
        size: 25,
        Icons.star,
        color: 5 < 3 ? Colors.yellow : Colors.grey,
      );
  }

    String? reviewResult = '';
   Future<void> makeReview({required String landmark,required String message,required int starsNumber,required String token}) async{
    //print('stars number : $starsNumber');
    postReview(landMark: landmark,message: message ,starsNumber: starsNumber, token: token)
        .then((value)
    {
      reviewResult = 'done';
      emit(PostReviewSuccessStates());
    }).catchError((error)
    {
      reviewResult = 'error';
      emit(PostReviewErrorStates());
      print('error review ${error.toString()}');
    });
  }




  List<Review>? reviewsList;
  void getLandMarkReviews({required String landMarkId})
  {
    fetchReviews(id: landMarkId).then((value)
    {
      reviewsList = value;
      //print(reviewsList);
      emit(GetLandMarkReviewsSuccessStates());
    }).catchError((error)
    {
      emit(GetLandMarkReviewsErrorStates());
      print(error.toString());
    });
  }



  int calculateStarsAverage(List<Review> reviewsList) {
    List<int> starsList = [];
    for (var review in reviewsList) {
      starsList.add(review.stars);
    }
    return getAverage(starsList);
  }

}
