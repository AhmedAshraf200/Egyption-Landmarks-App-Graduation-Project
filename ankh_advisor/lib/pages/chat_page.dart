import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/components/widgets.dart';
import 'package:ankh_advisor/cubits/chatCubit/chat%20states.dart';
import 'package:ankh_advisor/pages/model_info_page.dart';
import 'package:ankh_advisor/serves/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_advisor/cubits/chatCubit/chat_cubit.dart';
import '../../components/Constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var messageController = TextEditingController();
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getSuggestQ(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit chatCubit = ChatCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Ankh Advisor',
              ),
              actions: [
                IconButton(onPressed: ()
              {
                    navigateTo(context, ModelInfoPage());
                    //chatCubit.getClasses();
              },
                  icon: const Icon(Icons.info_outline))
              ],
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! GetSuggestQLoadingState ,
              fallback:(context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
              builder: (context) {
                return ConditionalBuilder(
                  condition: chatCubit.suggestModel != null,
                  fallback: (context) => const Center(child: Text('Opps There is an error ,Try again!')),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder<List<Widget>>(
                            stream: chatCubit.messageStream,
                            initialData:  [
                              SizedBox(
                                height: 380,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    const Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        height: 250,
                                        width: double.infinity,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          opacity: AlwaysStoppedAnimation(0.3),
                                          image: AssetImage(
                                            'Assets/images/AI.jpeg',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: defaultColor),
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            end: Alignment.topCenter,
                                            begin: Alignment.bottomCenter,
                                            colors:
                                            [
                                              Colors.grey.withOpacity(0.2),
                                              Colors.grey.withOpacity(0.5),
                                            ]),
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'I\'m Ankh Advisor.I am an expert artificial intelligence assistant who specializes in Egyptian history and heritage.I can help you answer any question in this field.Please feel free to ask anything.',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildSuggestQ(className: "${chatCubit.suggestModel![0]['className']}" ,emojis: "${chatCubit.suggestModel![0]['emojis']}", suggestQ: chatCubit.suggestModel![0]['question'],chatCubit: chatCubit,state:state),
                              buildSuggestQ(className: "${chatCubit.suggestModel![1]['className']}" ,emojis: "${chatCubit.suggestModel![1]['emojis']}", suggestQ: chatCubit.suggestModel![1]['question'],chatCubit: chatCubit,state:state),
                              buildSuggestQ(className: "${chatCubit.suggestModel![2]['className']}" ,emojis: "${chatCubit.suggestModel![2]['emojis']}", suggestQ: chatCubit.suggestModel![2]['question'],chatCubit: chatCubit,state:state),
                            ],
                            builder: (context, snapshot) {
                              return ListView(
                                controller:scrollController,
                                children: snapshot.data!,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.grey[400],
                                  height: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 15.0, left: 5, right: 5),
                                child: Container(
                                  height: 50,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.4),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          cursorColor: defaultColor,
                                          maxLines: 1,
                                          controller: messageController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '   type your message here...',
                                              hintStyle: TextStyle(
                                                height: 1.9,
                                              )
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shadowColor: Colors.white,
                                              title: const Center(child: Text('From ?')),
                                              content: Row(
                                                children: [
                                                  const Spacer(),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          if(state is! PostQLoadingState) {
                                                            chatCubit.pickImageGallery();
                                                          }
                                                          Navigator.pop(context);

                                                        },
                                                        icon: const Icon(Icons.image_outlined),
                                                      ),
                                                      const Text('Gallery')
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          if(state is! PostQLoadingState) {
                                                            chatCubit.pickImageCamera();
                                                          }
                                                          Navigator.pop(context);
                                                        },
                                                        icon: const Icon(Icons.camera_alt_outlined),
                                                      ),
                                                      const Text('Camera')
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.camera_enhance_outlined),
                                      ),
                                      Container(
                                        color: defaultColor,
                                        height: 55,
                                        width: 50,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            if(state is! PostQLoadingState) {
                                              if (messageController.text != '') {

                                                String question = messageController.text;
                                                chatCubit.askAiToList(question);

                                                messageController.clear();

                                                String answer = '';
                                                if (answer == '') {
                                                  chatCubit.addIndicatorToList();
                                                }
                                                answer = await postTextQ(className: chatCubit.className, question: question);

                                                if (answer != '' || state is! PostQLoadingState) {
                                                  chatCubit.removeLastFromList();
                                                }

                                                chatCubit.getAIAnswerToList(answer);

                                                scrollController.animateTo(
                                                  scrollController.position
                                                      .maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeIn,
                                                );
                                              }
                                              scrollController.animateTo(
                                                scrollController.position
                                                    .maxScrollExtent,
                                                duration: const Duration(
                                                    seconds: 1),
                                                curve: Curves.easeIn,
                                              );
                                            }
                                          },
                                          child: const Icon(Icons.send),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )


          );
        },
      ),
    );
  }
}
