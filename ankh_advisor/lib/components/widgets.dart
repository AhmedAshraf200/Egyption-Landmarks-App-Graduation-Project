import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/cubits/chatCubit/chat_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/models/home_data_model.dart';
import 'package:ankh_advisor/pages/landmark_page.dart';
import 'package:ankh_advisor/pages/login_page.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:ankh_advisor/serves/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubits/chatCubit/chat states.dart';

Widget recommendedItemBuilder(context,HomeMarks model, HomeLandMarksCubit homeLandMarksCubit) =>
    SizedBox(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              navigateTo(context, LandMarkPage());
              homeLandMarksCubit.getLandMarkReviews(landMarkId: model.id);
              homeLandMarksCubit.getLandMarkData(endPoint: 'landmarks', id: model.id);
              homeLandMarksCubit.getCityFilter(endPoint: 'cities');
            },
            child: Container(
              height: 190,
              width: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  style: BorderStyle.solid,
                  color: defaultColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(model.coverImage),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: 150,
              child: Text(
               model.name,
               style: const TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 12,
                 height: 2.2,
               ),
               overflow: TextOverflow.ellipsis,
               maxLines: 1,
                  ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:model.price != 0 ? Text(
                  'Price : ${model.price} Egyptian Pound / Ticket',
              style: const TextStyle(
                fontSize: 9,
                height: 1.2,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ) : Text(
              'Free',
              style: TextStyle(
                color: defaultColor,
                fontSize: 11
              ),
            ),
          )
        ],
      ),
    );

Widget mostRecentItemBuilder(context,HomeMarks model, HomeLandMarksCubit homeLandMarksCubit) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            navigateTo(context, LandMarkPage());
            homeLandMarksCubit.getLandMarkReviews(landMarkId: model.id);
            homeLandMarksCubit.getLandMarkData(endPoint: 'landmarks', id: model.id);
            homeLandMarksCubit.getCityFilter(endPoint: 'cities');
          },
          child: Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    style: BorderStyle.solid,
                    width: 1.5,
                    color: defaultColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(model.coverImage),
                    fit: BoxFit.cover
                  ),
                ),

              ),
               SizedBox(
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Spacer(),
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${model.views}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.spatial_audio_off_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 260,
                  child: Text(
                    model.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: ()async
                  {
                    ACCESSTOKEN = await CacheHelper.getData(key:'token')??'';
                    print(ACCESSTOKEN);
                    if(ACCESSTOKEN.isNotEmpty)
                    {
                      homeLandMarksCubit.likeLandMark(model.id, ACCESSTOKEN);
                     // homeLandMarksCubit.changeLikeIcon();
                      if(homeLandMarksCubit.likes.contains(model.id)){
                        model.likesCount--;
                        homeLandMarksCubit.likes.remove(model.id);
                      }
                      else{
                        model.likesCount++;
                        homeLandMarksCubit.likes.add(model.id);
                      }
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (context) =>  AlertDialog(
                          shadowColor: Colors.grey,
                          title: const Center(child: Text('To like you should LogIn',style: TextStyle(fontSize: 15),)),
                          content: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                    navigateTo(context, LoginPage());
                                  },
                                  child: const Text('Yes')),
                              const Spacer(),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: const Text('no')),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  icon: homeLandMarksCubit.likes.contains(model.id) ? Icon(Icons.favorite,color: defaultColor,):  Icon(Icons.favorite_border,color: defaultColor,),
                ),
                Text('${model.likesCount}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: model.price != 0 ? Text(

            'Price : ${model.price} Egyptian Pound / Ticket',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ) : Text(
            'Free',
            style: TextStyle(
              color: defaultColor,
              fontSize: 12
            ),
          ),
        ),
      ],
    );


Widget searchItemBuilder(context,HomeMarks model, HomeLandMarksCubit homeLandMarksCubit) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            navigateTo(context, LandMarkPage());
            homeLandMarksCubit.getLandMarkReviews(landMarkId: model.id);
            homeLandMarksCubit.getLandMarkData(endPoint: 'landmarks', id: model.id);
            homeLandMarksCubit.getCityFilter(endPoint: 'cities');
          },
          child: Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    style: BorderStyle.solid,
                    width: 1.5,
                    color: defaultColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(model.coverImage),
                    fit: BoxFit.cover
                  ),
                ),

              ),
               SizedBox(
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Spacer(),
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${model.views}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.spatial_audio_off_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    model.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: ()async
                  {
                    ACCESSTOKEN = await CacheHelper.getData(key:'token')??'';
                    print(ACCESSTOKEN);
                    if(ACCESSTOKEN.isNotEmpty)
                    {
                      homeLandMarksCubit.likeLandMark(model.id, ACCESSTOKEN);
                      // homeLandMarksCubit.changeLikeIcon();

                      if(homeLandMarksCubit.likes.contains(model.id)){
                        model.likesCount--;
                        homeLandMarksCubit.likes.remove(model.id);
                      }
                      else{
                        model.likesCount++;
                        homeLandMarksCubit.likes.add(model.id);
                      }
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (context) =>  AlertDialog(
                          shadowColor: Colors.grey,
                          title: const Center(child: Text('To like you should LOGIN',style: TextStyle(fontSize: 15),)),
                          content: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                    navigateTo(context, LoginPage());
                                  },
                                  child: const Text('Yes')),
                              const Spacer(),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: const Text('no')),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  icon: homeLandMarksCubit.likes.contains(model.id) ? Icon(Icons.favorite,color: defaultColor,):  Icon(Icons.favorite_border,color: defaultColor,),
                ),
                Text('${model.likesCount}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Price : ${model.price} Egyptian Pound / Ticket',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );


Widget myDivider() => const Padding(
  padding: EdgeInsets.symmetric(vertical: 10.0),
  child: Divider(color: Colors.grey,indent: 25,endIndent: 25,thickness: 0),
);



Widget buildAIMessage(String answer) => Padding(

      padding: const EdgeInsets.all(2.0),

      child: Container(

padding: const EdgeInsets.all(10),

decoration: const BoxDecoration(

    color: Colors.blueGrey,

    borderRadius: BorderRadiusDirectional.only(

      bottomStart: Radius.circular(7),

      //topEnd: Radius.circular(15),

      topStart: Radius.circular(7),

      bottomEnd: Radius.circular(7),

    )

),

child: Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.center,
    children:
    [
      const Padding(
        padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
        child: Icon(CupertinoIcons.snow),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 5.0,right: 10),
        child: Text('Ankh Advisor',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      Text(
        answer,
        style: const TextStyle(color:  Colors.white,),
        maxLines: null,
      ),
    ]
),

      ),

    );


Widget buildClassNameMessage(String answer) => Align(
  alignment: Alignment.center,
  child:   Padding(

        padding: const EdgeInsets.all(5.0),

        child: Container(

      padding: const EdgeInsets.all(10),

      decoration:  BoxDecoration(

      color: defaultColor,

      borderRadius: const BorderRadiusDirectional.all(Radius.circular(15)),

  ),

          child: Text(

            answer,

            style: const TextStyle(color:  Colors.white,),

            maxLines: null,

          ),

        ),

      ),
);

Widget buildMyMessage(String message) => Padding(
  padding: const EdgeInsets.all(2.0),
  child: Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(7),
          topEnd: Radius.circular(7),
          //topStart: Radius.circular(15),
          bottomStart: Radius.circular(7),
        )
    ),
    child: Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children:
      [
        const Padding(
          padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
          child: Icon(CupertinoIcons.person),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0,right: 10),
          child: Text('You',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        ),
        Text(
          message,
          style: const TextStyle(color:  Colors.white,),
          maxLines: null,
        ),
      ]
    ),
  ),
);



Widget buildSuggestQ({required String suggestQ, required String className, required String emojis,required ChatCubit chatCubit,state}) => Container(
  margin: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(width: 1,color: defaultColor),
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.2),
  ),
  width: double.infinity,
  child:  InkWell(
    onTap: () async
    {
      chatCubit.askAiToList(suggestQ);
      String answer = '';
      if(answer == '')
      {
        chatCubit.addIndicatorToList();
      }
      answer = await postTextQ(className: className,question:suggestQ);
      if(answer != '' || state is! PostQLoadingState)
      {
        chatCubit.removeLastFromList();
      }
      chatCubit.getAIAnswerToList(answer);
    },
    child: Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        children: [
          const Icon(Icons.ac_unit_sharp,),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                child: Wrap(
                  direction: Axis.horizontal,
                    children: [
                      Text(
                        className,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        emojis,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                ),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  suggestQ,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);



// SliverAppBar(
// title: Padding(
// padding: const EdgeInsets.all(20.0),
// child: Container(
// decoration: BoxDecoration(
// color: Colors.grey[200],
// border: Border.all(
// style: BorderStyle.solid,
// color: defaultColor,
// ),
// borderRadius: BorderRadius.circular(15),
// ),
// child: const TextField(
// decoration: InputDecoration(
// prefixIcon: Icon(Icons.search_outlined),
// hintText: 'Try "Luxor"',
// hintStyle: TextStyle(color: Colors.grey),
// border: InputBorder.none),
// ),
// ),
// ),
// pinned: false,
// floating: true,
// snap: true,
// ),
