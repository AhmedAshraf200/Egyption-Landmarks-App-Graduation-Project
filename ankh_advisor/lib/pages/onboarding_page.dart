import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/pages/home_page.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ankh_advisor/components/Constants.dart';
import 'package:flutter/material.dart';


class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'Assets/images/pngegg.png',
      body: 'Embark on a digital journey through Egypt\'s iconic landmarks. Explore the mysteries of the pyramids, sail the Nile\'s historic waters, and marvel at the temples\' grandeur—all from the palm of your hand. Immerse yourself in the rich tapestry of Egypt\'s cultural heritage through this captivating app.',
      title: 'Egypt LandMarks',
    ),
    BoardingModel(
      image: 'Assets/images/pngegg (4).png',
      body: 'Utilize the AI assistant to capture images of landmarks or provide instant answers to your inquiries. Whether you seek historical context or navigation guidance, the AI is at your service. Seamlessly integrate its capabilities into your exploration, enhancing your experience within the application.',
      title: 'Ankh Advisor',
    ),
    BoardingModel(
      image: 'Assets/images/pngegg (5).png',
      body: 'Feel empowered to explore and engage with the app, asking any question that sparks your curiosity. Embrace the freedom to delve into Egypt\'s wonders, knowing the AI is here to assist you every step of the way. Unleash your curiosity and let the app be your gateway to discovery.',
      title: 'Explore Freely with AI Assistance',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()
            {
              navigateAndFinish(context, HomePage());
              submit();
            },
            child:  Text(
              'SKIP',
              style: TextStyle(
                color: defaultColor,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column (
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                onPageChanged: (int index)
                {
                  if( index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 50.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
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
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    onPressed: ()
                    {
                      if(isLast)
                      {
                        navigateAndFinish(context, HomePage());
                        submit();
                      }
                      else{
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.easeInOut);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void submit()
  {
    CacheHelper.saveData(key:'OnBoarding', value: true)
        .then((value)
    {
      if(value)
      {
        navigateAndFinish(context, HomePage());
      }
    }
    ).catchError((error)
    {
      print(error.toString());
    });
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          //fit: BoxFit.cover,
          image: AssetImage(
              model.image,
          ),
          opacity: const AlwaysStoppedAnimation(0.8),
        ),
      ),
      const SizedBox(height: 15,),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      const SizedBox(height: 15,),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const SizedBox(height: 30,),
    ],
  );

}
