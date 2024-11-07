import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/widgets.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultFilterPage extends StatelessWidget {

  final String filterName;

  const ResultFilterPage({super.key, required this.filterName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLandMarksCubit,LandMarksStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = HomeLandMarksCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title:  Text(filterName),
            ),
            body:  ConditionalBuilder(
              condition: state is! GetResultFilterLoadingState && cubit.resultFilterModel != null,
              fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
              builder: (context)
              {
                return ConditionalBuilder(
                condition: cubit.resultFilterModel!.data.isNotEmpty && cubit.cityList!.isNotEmpty,
                fallback: (context) => const Center(
                  child: Text('There is no result!'),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      itemCount: cubit.resultFilterModel!.data.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return searchItemBuilder(
                          context,
                          cubit.resultFilterModel!.data[index],
                          HomeLandMarksCubit.get(context),
                        );
                      },
                    ),
                  );
                },
              );
            },
            ),
        );
      },
    );
  }
}
