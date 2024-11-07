import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// ignore: must_be_immutable
class ImagePage extends StatelessWidget {

  var boardController = PageController();

  final HomeLandMarksCubit cubit;

  ImagePage({super.key, required this.cubit,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            SizedBox(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return PhotoView(
                    imageProvider: NetworkImage(
                      cubit.landMarksModel!.images[index],
                    ),
                  );
                },
                itemCount: cubit.landMarksModel!.images.length,
                controller: boardController,
                physics: const NeverScrollableScrollPhysics(),
                allowImplicitScrolling: true,
                onPageChanged: (int index){},
              ),
            ),
            SizedBox(
              child: Column(
                children: [
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
            Row(
              children: [
                Container(
                  width: 30,
                  color: Colors.grey.withOpacity(0.6),
                  child:  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: ()
                    {
                      {
                        boardController.previousPage(
                          duration: const Duration(
                            milliseconds: 250,
                          ),
                          curve: Curves.linear,
                        );
                      }
                    },
                  ),
                ),
                const Spacer(),
                Container(
                  width: 30,
                  color: Colors.grey.withOpacity(0.6),
                  child:  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: (){
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 250,
                          ),
                          curve: Curves.linear,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
