import 'dart:async';
import 'dart:io';
import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/cubits/chatCubit/chat%20states.dart';
import 'package:ankh_advisor/serves/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/widgets.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<Widget> messageList = [];
  final StreamController<List<Widget>> _messageStreamController =
  StreamController<List<Widget>>.broadcast();
  
  Stream<List<Widget>> get messageStream => _messageStreamController.stream;


  String className = '' ;
  File? image;
  var picker = ImagePicker();

  Future<void> pickImageGallery() async {
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {

      image = File(imagePicked.path);
      String answer = '';

      messageList.add(Image.file(
        File(imagePicked.path),
        width: double.infinity,
        fit: BoxFit.cover,
      ));

      addImageToList();
      emit(PostQLoadingState());
      if(className == '' || state is PostQLoadingState)
      {
        addIndicatorToList();
      }

      className = await postImage(image: image);
      if(className != 'unknown') {
        answer = await postInfo(className: className);
      }
      emit(GetClassNameSuccessState());


      if(state is! PostQLoadingState || (answer != '' && className != '') )
      {
        removeLastFromList();
      }

      if(className != 'unknown') {
        getAIAnswerClassNameToList(className);
        getAIAnswerToList(answer);
      }


      if(className == 'unknown')
      {
        getAIAnswerToList('unknown, Thank you for sharing the image. However, it appears that I\'m currently unable to recognize or analyze the content of the image.\nWhile I can provide information and answer questions based on text input, image recognition is not supported at the moment.\nIf you have any text-based questions or need information on a specific topic, please let me know—I’d be happy to help!\nBest regards,');
      }


      emit(ChatImagePickedSuccessState());

    } else {
      emit(ChatImagePickedErrorState());
    }
  }

  Future<void> pickImageCamera() async {
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.camera);

    if (imagePicked != null) {

      image = File(imagePicked.path);
      String answer = '';

      messageList.add(Image.file(
        File(imagePicked.path),
        width: double.infinity,
        fit: BoxFit.cover,
      ));

      addImageToList();
      emit(PostQLoadingState());
      if(className == '' || state is PostQLoadingState)
      {
        addIndicatorToList();
      }

      className = await postImage(image: image);
      if(className != 'unknown') {
        answer = await postInfo(className: className);
      }
      emit(GetClassNameSuccessState());


      if(state is! PostQLoadingState || (answer != '' && className != '') )
      {
        removeLastFromList();
      }

      if(className != 'unknown') {
        getAIAnswerClassNameToList(className);
        getAIAnswerToList(answer);
      }


      if(className == 'unknown')
      {
        getAIAnswerToList('unknown, Thank you for sharing the image. However, it appears that I\'m currently unable to recognize or analyze the content of the image.\nWhile I can provide information and answer questions based on text input, image recognition is not supported at the moment.\nIf you have any text-based questions or need information on a specific topic, please let me know—I’d be happy to help!\nBest regards,');
      }


      emit(ChatImagePickedSuccessState());

    } else {
      emit(ChatImagePickedErrorState());
    }
  }



  void addImageToList()
  {
    _messageStreamController.add(messageList.toList()); // add image to list
  }


  String? response;
  Future<void> postTextQuestion({required String question,required String className,})
  async {
    emit(PostQLoadingState());
    postTextQ(question: question, className: className).then((value)
    async {
      response = await value;
      emit(PostQSuccessState());
    }).catchError((error){
      emit(PostQErrorState());
      print(error.toString());
    });
  }





  void askAiToList(String message) {

    messageList.add(buildMyMessage(message));
    _messageStreamController.add(messageList.toList());
    emit(GetResponseSuccessState());
    emit(PostQLoadingState());

  }

  String? answer;
  Future<void> getAIAnswerToList(String aiAnswer) async {

    answer = aiAnswer;
    messageList.add(buildAIMessage(answer!));
    _messageStreamController.add(messageList.toList());

    emit(AddResponseToListSuccessState());
  }

  Future<void> getAIAnswerClassNameToList(String aiAnswer) async {

    answer = aiAnswer;
    messageList.add(buildClassNameMessage(answer!));
    _messageStreamController.add(messageList.toList());

    emit(AddResponseToListSuccessState());
  }

  Future<void> getAIAnswerWithImageToList(String aiAnswer) async {
    answer = aiAnswer;
    messageList.add(buildAIMessage(answer!));
    _messageStreamController.add(messageList.toList());
    emit(AddResponseToListSuccessState());
  }

  Future<void> streamClose() {
    _messageStreamController.close();
    return super.close();
  }


  List<dynamic>? suggestModel;
  void getSuggestQ()
  {
    emit(GetSuggestQLoadingState());
    getSuggestQuestion().then((value)
    {
      //print(value[0]['className']);
      suggestModel = value;
      emit(GetSuggestQSuccessState());
    }).catchError((error)
    {
      emit(GetSuggestQErrorState());
      print("error is : $error");
    });
  }


    void addIndicatorToList() {
    messageList.add( Padding(
      padding: const EdgeInsets.all(5.0),
      child: LinearProgressIndicator(color: defaultColor,),
    ));
    _messageStreamController.add(messageList.toList());
  }

    void removeLastFromList() {
    messageList.removeLast();
    _messageStreamController.add(messageList.toList());
  }





  List<dynamic>? classesNames;
  void getClasses()
  {
    emit(GetClassesInfoNameLoadingState());
    getClassesNames().then((value)
    {
      classesNames = value;
    emit(GetClassesInfoNameSuccessState());
    }).catchError((error)
    {
      emit(GetClassesInfoNameErrorState());
      print(error.toString());

    });
  }
}
