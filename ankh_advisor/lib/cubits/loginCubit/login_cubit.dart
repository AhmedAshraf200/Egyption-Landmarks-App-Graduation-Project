import 'package:ankh_advisor/cubits/loginCubit/login_states.dart';
import 'package:ankh_advisor/serves/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  bool isPasswordIconChanged = false;
  void changePasswordIcon()
  {
    isPasswordIconChanged = !isPasswordIconChanged;
    emit(ChangePasswordIconState());
  }


  String? token;
  String? userName;
  void userLogin({
    required String email,
    required String password
  }) {
    emit(LoginLoadingState());
    dio.post('https://landmarks-proejct.onrender.com/api/v1/auth/login', data: {
      'email': email,
      'password': password,
    })
        .then((value) {
          token = value.data['access_token'];
          userName = value.data['name'];
          print('access_token from login : ${value.data['access_token']}');
          emit(LoginSuccessState());
    })
        .catchError((error) {
        emit(LoginErrorState());
        print(error.toString());
    });
  }

}