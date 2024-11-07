import 'dart:io';
import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/models/fliter_model.dart';
import 'package:ankh_advisor/models/home_data_model.dart';
import 'package:ankh_advisor/models/land_marks_model.dart';
import 'package:ankh_advisor/models/reviews_model.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();


Future<void> getModelUrl() async {
  Dio dio = Dio();
  Response response = await dio.get(
    'https://landmarks-proejct.onrender.com/api/v1/llm',
  );
  modelUrl = response.data['url'];
  print('modellllll $modelUrl');
}

Future<HomeLandMarksModel> fetchMostRecentData() async {
  try {
    var response = await dio.get(
        'https://landmarks-proejct.onrender.com/api/v1/landmarks?sort=createdAt');
    //print(response.data['data'][0]['name']);
    return HomeLandMarksModel.fromJson(response.data);
  } catch (e) {
    print('Request error: $e');
    rethrow; // You might want to handle the error appropriately in your UI
  }
}

Future<HomeLandMarksModel> fetchRecommendedData() async {
  try {
    var response = await dio.get(
        'https://landmarks-proejct.onrender.com/api/v1/landmarks?sort=likes');
    //print(response.data['data'][0]['name']);
    return HomeLandMarksModel.fromJson(response.data);
  } catch (e) {
    print('Request error: $e');
    rethrow; // You might want to handle the error appropriately in your UI
  }
}

Future<LandMarksModel> fetchData({required String endPoint, String? id}) async {
  try {
    var response = await dio
        .get('https://landmarks-proejct.onrender.com/api/v1/$endPoint/$id');
    //print(response.data['data'][0]['name']);
    return LandMarksModel.fromJson(response.data);
  } catch (e) {
    print('Request error: $e');
    rethrow; // You might want to handle the error appropriately in your UI
  }
}


Future<List<CityModel>> fetchFilter({required String endPoint}) async {
  try {
    Response response = await dio.get('https://landmarks-proejct.onrender.com/api/v1/$endPoint');
    List<dynamic> jsonData = response.data;
    List<CityModel> cities = jsonData.map((item) => CityModel.fromJson(item)).toList();
    return cities;
  } catch (e) {
    print('Request error: $e');
    throw Exception('Failed to fetch data: $e');
  }
}

Future<HomeLandMarksModel> getSearch(String search) async {
  try {
    var response = await dio.get(
        'https://landmarks-proejct.onrender.com/api/v1/landmarks?search=$search');
    //print(response.data['data'][0]['name']);
    return HomeLandMarksModel.fromJson(response.data);
  } catch (e) {
    print('Request error: $e');
    rethrow; // You might want to handle the error appropriately in your UI
  }
}

Future<HomeLandMarksModel> fetchResultFilter({required String endPoint, required String id}) async {
  try {
    var response = await dio.get(
        'https://landmarks-proejct.onrender.com/api/v1/landmarks?$endPoint=$id');
    //print(response.data['data'][0]['name']);
    return HomeLandMarksModel.fromJson(response.data);
  } catch (e) {
    print('Request error: $e');
    rethrow; // You might want to handle the error appropriately in your UI
  }
}

Future<dynamic> postImage({required File? image}) async {
  Dio dio = Dio();

  if (image == null) {
    throw Exception('No file selected');
  }
  FormData formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(image.path),
  });


  try {
    Response response = await dio.post(
      '$modelUrl/predict',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    print(response.data);

    return response.data;

    // if (response.statusCode == 200) {
    //   return PredictedClass.fromJson(response.data);
    // } else {
    //   throw Exception('Failed to post message');
    // }
  } catch (e) {
    throw Exception('Failed to post message: $e');
  }

}

Future<dynamic> postInfo({required String className}) async {
  Dio dio = Dio();


  if (className.isEmpty) {
    throw Exception('No file selected');
  }

    Response response = await dio.post(
      '$modelUrl/chat',
      data : {'class_name' : className,},
    );

    print(response.data.toString());
    return response.data;


}

Future<dynamic> postTextQ({String? className = '',required String question}) async {
  Dio dio = Dio();
  // if (className!.isEmpty) {
  //   throw Exception('No file selected');
  // }
    Response response = await dio.post(
      '$modelUrl/chat',
      data : {
          'class_name' : className,
          'user_question' : question,
      },
    );
    print(response.data.toString());
    return response.data;
}

Future<dynamic> toggleLike({required String id,required String token}) async {
  Dio dio = Dio();



  Response response = await dio.patch(
     'https://landmarks-proejct.onrender.com/api/v1/likes',
    data : {
       'landmark' : id,
    },
    options: Options(
      headers: {
        "Authorization": "Bearer $token"
      },
    ),
  );

  print(response.data.toString());
  return response.data;


}


Future<dynamic> postReview({required String landMark,required int starsNumber, required String message,required String token}) async {
  Dio dio = Dio();
  print('$landMark $starsNumber $message' );

  Response response = await dio.post(
     'https://landmarks-proejct.onrender.com/api/v1/reviews',
    data : {
      "landmark":landMark,
      "stars":starsNumber,
      "message":message
    },
    options: Options(
      headers: {
        "Authorization": "Bearer $token"
      },
    ),
  );

  //print(response.data.toString());
  return response.data;


}


Future<List<Review>> fetchReviews({required String id}) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('https://landmarks-proejct.onrender.com/api/v1/reviews/$id');
    List<dynamic> jsonData = response.data;
    List<Review> reviews = jsonData.map((item) => Review.fromJson(item)).toList();
    return reviews;
  } catch (e) {
    print('Request error: $e');
    throw Exception('Failed to fetch data: $e');
  }
}




Future<List<dynamic>> getAllLikes({required String token}) async {
  Dio dio = Dio();

  Response response = await dio.get(
    'https://landmarks-proejct.onrender.com/api/v1/likes',
    options: Options(
      headers: {
        "Authorization": "Bearer $token"
      },
    ),
  );

  print(response.data.toString());
  return response.data;
}


Future<List<dynamic>> getSuggestQuestion() async {
  Dio dio = Dio();

  Response response = await dio.get(
    '$modelUrl/suggest',
  );

  //print(response.data);
  return response.data;
}


Future<List<String>> getClassesNames() async {
  Dio dio = Dio();

  Response response = await dio.get(
    '$modelUrl/classes',
  );

  //print(response.data);
  return response.data;
}





