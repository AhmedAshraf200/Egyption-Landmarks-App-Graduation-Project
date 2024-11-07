import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:ankh_advisor/pages/result_filter_page.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {

    var cubit = HomeLandMarksCubit.get(context);

    return BlocConsumer<HomeLandMarksCubit, LandMarksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Filter by :"),
          ),
          body: ConditionalBuilder(
            condition: cubit.tagList != null && cubit.cityList != null,
            fallback:(context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
            builder:(context) => SafeArea(
              child:  Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'City',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        child: Wrap(
                          children: List.generate(
                              cubit.cityList!.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: (){
                                    navigateTo(context, ResultFilterPage(filterName: cubit.cityList![index].name));
                                    cubit.getResultFilter('cities', cubit.cityList![index].id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: defaultColor,
                                        )
                                    ),
                                    child:   Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.cityList![index].name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      const Text(
                        'tag',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        child: Wrap(
                          children: List.generate(
                              cubit.tagList!.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: (){
                                    navigateTo(context, ResultFilterPage(filterName: cubit.tagList![index].name));
                                    cubit.getResultFilter('tags', cubit.tagList![index].id);

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: defaultColor,
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.tagList![index].name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
