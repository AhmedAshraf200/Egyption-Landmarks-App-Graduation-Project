import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/components/widgets.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:ankh_advisor/pages/Map.dart';
import 'package:ankh_advisor/pages/chat_page.dart';
import 'package:ankh_advisor/pages/full_description_page.dart';
import 'package:ankh_advisor/pages/image_page.dart';
import 'package:ankh_advisor/pages/login_page.dart';
import 'package:ankh_advisor/pages/result_filter_page.dart';
import 'package:ankh_advisor/pages/review_page.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



// ignore: must_be_immutable
class LandMarkPage extends StatelessWidget {
  LandMarkPage({super.key});


  var boardController = PageController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeLandMarksCubit,LandMarksStates>(
      listener:(context, state) {},
      builder: (context, state) {

        var cubit = HomeLandMarksCubit.get(context);

        return  Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: defaultColor,
            splashColor: defaultColor.withOpacity(0.5),
            onPressed: () {
              navigateTo(context, ChatPage());
            },
            shape: const CircleBorder(),
            elevation: 5,
            child: const Icon(
              Icons.chat_outlined,
            ),
          ),
                body: ConditionalBuilder(
                  condition: state is! LandMarksLoadingStates && cubit.cityList != null && cubit.reviewsList != null && cubit.landMarksModel != null,
                  fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
                  builder:(context) {
                    return SafeArea(
                      child: ConditionalBuilder(
                        condition: cubit.cityList != null,
                        fallback: (context) => const Center(child: Text('Ops there was an error! ,try again later.'),),
                        builder: (context) =>SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: ()
                                {
                                  navigateTo(context, ImagePage(cubit: cubit,));
                                },
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: PageView.builder(
                                        itemBuilder: (context, index) {
                                          return Image.network(
                                            cubit.landMarksModel!.images[index],
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        itemCount: cubit.landMarksModel!.images.length,
                                        controller: boardController,
                                        onPageChanged: (int index){},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 250,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: SmoothPageIndicator(
                                                  controller: boardController,
                                                  count: cubit.landMarksModel!.images.length,
                                                  effect:
                                                  ExpandingDotsEffect(
                                                    dotColor: Colors.grey,
                                                    activeDotColor: defaultColor,
                                                    dotHeight: 10,
                                                    dotWidth: 10,
                                                    expansionFactor: 4,
                                                    radius: 20,
                                                    spacing: 5,
                                                  ),
                                                  //onDotClicked: (index) => Boarding[index],
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              cubit.landMarksModel!.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                height: 1.5,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () async
                                            {
                                              ACCESSTOKEN = await CacheHelper.getData(key:'token')??'';
                                              //print(ACCESSTOKEN);
                                              if(ACCESSTOKEN.isNotEmpty)
                                              {
                                                cubit.likeLandMark(cubit.landMarksModel!.id, ACCESSTOKEN);
                                                //cubit.changeLikeIcon();

                                                if(cubit.likes.contains(cubit.landMarksModel!.id,)){
                                                  cubit.landMarksModel!.likesCount--;
                                                  cubit.likes.remove(cubit.landMarksModel!.id,);
                                                }
                                                else{
                                                  cubit.landMarksModel!.likesCount++;
                                                  cubit.likes.add(cubit.landMarksModel!.id);
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
                                            icon: cubit.likes.contains(cubit.landMarksModel!.id) ? Icon(Icons.favorite,color: defaultColor,):  Icon(Icons.favorite_border,color: defaultColor,),
                                          ),
                                          Text('${cubit.landMarksModel!.likesCount}')
                                        ],
                                      ),
                                    ),
                                    Text(
                                      cubit.landMarksModel!.city.name,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    myDivider(),
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                      cubit.landMarksModel!.description,
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 15,),
                                    if(cubit.landMarksModel!.tags.isNotEmpty)
                                      SizedBox(
                                          height: 40,
                                          child:ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) => const SizedBox(width: 8,),
                                            itemCount: cubit.landMarksModel!.tags.length,
                                            itemBuilder:(context, index) => InkWell(
                                              onTap: ()
                                              {
                                                cubit.getResultFilter('tags', cubit.landMarksModel!.tags[index].id);
                                                navigateTo(context, ResultFilterPage(filterName: cubit.landMarksModel!.tags[index].name));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: defaultColor,
                                                    )
                                                ),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    cubit.landMarksModel!.tags[index].name,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    const SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap: (){
                                        navigateTo(context, FullDescriptionPage(description: cubit.landMarksModel!.description,name: cubit.landMarksModel!.name));
                                      },
                                      child:  Text(
                                        'Read Full Description',
                                        style: TextStyle(
                                          color: defaultColor,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          decorationColor: defaultColor,
                                        ),
                                      ),
                                    ),
                                    myDivider(),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: ()
                                          {
                                            cubit.playAudio(cubit.landMarksModel!.description);
                                          },
                                          icon:  Icon(cubit.isSpeaking ? Icons.pause_circle_outline : Icons.play_circle_outline,
                                            color: defaultColor,
                                            size: 50,
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        GestureDetector(
                                          onTap: (){
                                            cubit.playAudio(cubit.landMarksModel!.description);
                                          },
                                          child: const Text(
                                            'Play Audio Guide',
                                            style: TextStyle(
                                              fontSize: 18,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    myDivider(),
                                    if(cubit.landMarksModel!.era != null && cubit.landMarksModel!.famousFigures != null || cubit.landMarksModel!.era != ''&& cubit.landMarksModel!.famousFigures != '')
                                      const Text(
                                      'History',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    if(cubit.landMarksModel!.era != null && cubit.landMarksModel!.era != '')
                                    Row(
                                      children: [
                                        const Text(
                                          'Era : ',
                                        ),
                                        Expanded(
                                          child: Text(
                                            cubit.landMarksModel!.era!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: defaultColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(cubit.landMarksModel!.famousFigures != null)
                                    Row(
                                      children: [
                                        if(cubit.landMarksModel!.famousFigures!.isNotEmpty)
                                        const Text(
                                          'Famous Figures : ',
                                        ),
                                        Expanded(
                                          child: Text(
                                            cubit.landMarksModel!.famousFigures!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: defaultColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(cubit.landMarksModel!.era != null && cubit.landMarksModel!.famousFigures != null || cubit.landMarksModel!.era != ''&& cubit.landMarksModel!.famousFigures != '')
                                    myDivider(),
                                    const Text(
                                      'Location',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Row(
                                           children: [
                                             SizedBox(
                                               width: 270,
                                               child: Text(
                                                 cubit.landMarksModel!.location.name,
                                               ),
                                             ),
                                             const Spacer(),
                                             IconButton(onPressed: ()
                                             {
                                               navigateTo(context,MapScreen(latitude: cubit.landMarksModel!.location.latitude, longitude: cubit.landMarksModel!.location.longitude));
                                             }, icon: const Icon(Icons.zoom_out_map_outlined,),
                                             )
                                           ],
                                         ),
                                         const SizedBox(height: 5,),
                                         SizedBox(
                                           width: double.infinity,
                                           height: 250,
                                           child:  MapScreen(latitude: cubit.landMarksModel!.location.latitude, longitude: cubit.landMarksModel!.location.longitude,) ,
                                         ),
                                       ],
                                     ),
                                    myDivider(),
                                    const Text(
                                      'Reviews',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        children: [
                                          Row(
                                            children: List.generate(5, (index) =>
                                             Icon(
                                              size: 25,
                                              Icons.star,
                                              color: cubit.calculateStarsAverage(cubit.reviewsList!) > index ? Colors.yellow : Colors.grey,),
                                              growable: true
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(
                                              '( ${cubit.calculateStarsAverage(cubit.reviewsList!)} )',
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    ConditionalBuilder(
                                      condition: cubit.reviewsList!.isNotEmpty,
                                      fallback: (context) => Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: defaultColor,
                                            )
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(30.0),
                                          child: Column(
                                            children: [
                                              Icon(Icons.reviews),
                                              SizedBox(height: 10),
                                              Text(
                                                'No reviews yet!',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Write your opinion and help the',
                                              ),
                                              Text(
                                                'community by sharing your experience',
                                              ),
                                              Text(
                                                'about this place.',
                                              ),
                                            ],
                                          ),
                                        ) ,
                                      ),
                                      builder: (context)
                                        {
                                          return Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: defaultColor,
                                                )
                                            ),
                                            child:  Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: ListView.separated(
                                                  itemBuilder: (context, index) {
                                                      return Row(
                                                      children: [
                                                        Text('${index+1} - '),
                                                        Expanded(
                                                          child: Text(
                                                            cubit.reviewsList![index].message,
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        const Icon(Icons.star,color: Colors.yellow,),
                                                        Text('(${cubit.reviewsList![index].stars})'),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder: (context, index) => Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Container(color: Colors.grey,height: 0.5,width: double.infinity,),
                                                  ),
                                                  itemCount: cubit.reviewsList!.length,
                                              ),
                                            ) ,
                                          );
                                        },
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: defaultColor,
                                          )
                                      ),
                                      child: TextButton(
                                        onPressed: () async {
                                          ACCESSTOKEN = await CacheHelper.getData(key:'token')??'';
                                          if(ACCESSTOKEN.isNotEmpty) {
                                            navigateTo(context, ReviewPage(name: cubit.landMarksModel!.name,cubit: cubit,));
                                          }
                                          else{
                                            showDialog(
                                              context: context,
                                              builder: (context) =>  AlertDialog(
                                                shadowColor: Colors.grey,
                                                title: const Center(child: Text('To comment you should LOGIN',style: TextStyle(fontSize: 15),)),
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
                                        child:  Text(
                                          'write your review',
                                          style: TextStyle(
                                            color: defaultColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    myDivider(),
                                    if(cubit.landMarksModel!.openingHours != 'Unknown')
                                    const Text(
                                      'Opening Hours',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    if(cubit.landMarksModel!.openingHours != 'Unknown')
                                      Text(
                                      cubit.landMarksModel!.openingHours,
                                    ),
                                    if(cubit.landMarksModel!.openingHours != 'Unknown')
                                      myDivider(),
                                    const Text(
                                      'Prices',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.monetization_on_outlined,color: defaultColor),
                                        const SizedBox(width: 10,),
                                        if(cubit.landMarksModel!.price != 0)
                                        Row(
                                          children: [
                                            Text(
                                              '${cubit.landMarksModel!.price} EGP',
                                              style: TextStyle(
                                                color: defaultColor,
                                              ),
                                            ),
                                            const Text(
                                              '/ Ticket',
                                            ),
                                          ],
                                        ),
                                        if(cubit.landMarksModel!.price == 0)
                                          Text('Free',style: TextStyle(color: defaultColor,fontSize: 18),),
                                      ],
                                    ),
                                    myDivider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );

      },
    );
  }
}
