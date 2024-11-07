import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPage extends StatelessWidget {
  final String name;
  final HomeLandMarksCubit cubit;
   const ReviewPage({super.key,required this.name,required this.cubit});

  @override
  Widget build(BuildContext context) {

    var reviewController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Write a review'),
      ),
      body: BlocConsumer<HomeLandMarksCubit,LandMarksStates>(
        listener:(context, state) {},
        builder:(context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: defaultColor,
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('How was your visit to',style: TextStyle(fontSize: 19),),
                        Text(
                          '$name ?', style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 15,),
                        Center(
                          child: Row(
                            children: [
                              const Spacer(),
                              Row(
                                children: List.generate(5, (index) => cubit.buildStar(index),),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child:  Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: reviewController,
                    // validator:(String? value) {
                    //   if(value!.isEmpty)
                    //   {
                    //     return 'Write Your review';
                    //   }
                    //   return null;
                    // },
                    decoration: const InputDecoration(
                      hintText: '📌 Write your review here...',
                    ),
                    expands: true,
                    maxLines: null,
                  ),
                )),
                TextButton(
                  onPressed: (){},
                  child:  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: defaultColor,
                        )
                    ),
                    child: TextButton(
                      onPressed: () async {
                        print('first result : ${cubit.reviewResult}');
                        if(reviewController.text != '' ) {
                          await cubit.makeReview(landmark: cubit.landMarksModel!.id, message: reviewController.text, starsNumber: cubit.starsIndex,token: ACCESSTOKEN);
                          if(cubit.reviewResult == 'done') {
                            showToast(text: 'Thanks for your review', state: ToastState.SUCCESS);
                            Navigator.pop(context);
                            print('success result : ${cubit.reviewResult}');
                            cubit.reviewResult = '';
                          }
                        }
                         if(reviewController.text == '' || cubit.reviewResult == 'error') {

                             await cubit.makeReview(
                                 landmark: cubit.landMarksModel!.id,
                                 message: reviewController.text,
                                 starsNumber: cubit.starsIndex,
                                 token: ACCESSTOKEN);
                             showToast(text: 'error ,try again later!',
                                 state: ToastState.WRONG);
                             print('error result : ${cubit.reviewResult}');
                             cubit.reviewResult = '';

                        }
                      },
                      child:  Text(
                        'Submit',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
