import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/homeLandMaksCubit/home_land_marks_states.dart';


class ModelInfoPage extends StatelessWidget {
  const ModelInfoPage({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  'Welcome to our AI-powered assistant designed to help you learn about Egyptian landmarks, antiquities and history. Our advanced model is equipped to provide detailed information about various landmarks and artifacts, enhancing your understanding of Egypt\'s rich cultural heritage. Additionally, our AI can recognize and analyze images of Egyptian relics, offering explanations and insights.\n\nWhile we strive to ensure the accuracy and reliability of the information provided, it is important to note that occasional errors may occur. As such, we recommend using our AI as a supplementary tool and cross-referencing the information with reliable sources to verify its accuracy.\n\nWe are committed to delivering a valuable educational experience and appreciate your understanding and caution while using our AI assistant.\n\nShould you have any questions or require further assistance, please feel free to reach out.',
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
