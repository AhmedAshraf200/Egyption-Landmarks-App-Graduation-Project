import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/homeLandMaksCubit/home_land_marks_states.dart';


class FullDescriptionPage extends StatelessWidget {
   final String description;
   final String name;

   const FullDescriptionPage({super.key, required this.description, required this.name,
  });





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: BlocConsumer<HomeLandMarksCubit,LandMarksStates>(
        listener: (context, state) {},
        builder:(context, state) {

          var cubit = HomeLandMarksCubit.get(context);

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cubit.isDark ? Colors.grey[800] : Colors.grey[200],
                  border: Border.all(
                    color: defaultColor,
                  )
              ),
              margin: const EdgeInsets.all(20),
              child:  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  style:  TextStyle(
                    color: cubit.isDark ? Colors.grey[200] : Colors.grey[800],
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
