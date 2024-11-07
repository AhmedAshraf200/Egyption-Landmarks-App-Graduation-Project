import 'package:ankh_advisor/components/Constants.dart';
import 'package:ankh_advisor/components/functions.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_cubit.dart';
import 'package:ankh_advisor/cubits/homeLandMaksCubit/home_land_marks_states.dart';
import 'package:ankh_advisor/pages/chat_page.dart';
import 'package:ankh_advisor/pages/filter_page.dart';
import 'package:ankh_advisor/pages/login_page.dart';
import 'package:ankh_advisor/pages/onboarding_page.dart';
import 'package:ankh_advisor/serves/cache/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/widgets.dart';


// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  var searchController = TextEditingController();

  Future<void> refresh()
  {
    return Future.delayed(const Duration(seconds:2));
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeLandMarksCubit, LandMarksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var mostRecentModel = HomeLandMarksCubit.get(context).mostRecentLandMarksModel;
        var recommendedRecentModel = HomeLandMarksCubit.get(context).recommendedLandMarksModel;
        var cubit = HomeLandMarksCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Container(
              height: 37,
              decoration: BoxDecoration(
                color: CacheHelper.getBoolean(key: 'isDark')?? true
                    ? Colors.grey[500]
                    : Colors.grey[200],
                // border: Border.all(
                //   style: BorderStyle.solid,
                //   color: defaultColor,
                // ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                cursorColor: defaultColor,
                maxLines: 1,
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_outlined),
                    suffixIcon: searchController.text != '' ? IconButton(
                      onPressed: ()
                      {
                        searchController.clear();
                        cubit.clearSearch();
                      },
                      icon: const Icon(Icons.clear),) : null,
                    hintText: 'Try "Pyramids"',
                    hintStyle: TextStyle(
                        color: CacheHelper.getBoolean(key: 'isDark')?? true
                            ? Colors.grey[300]
                            : Colors.grey),
                    border: InputBorder.none),
                onChanged: (value){cubit.getSearchData(value);},
              ),
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  cubit.getTagFilter(endPoint: 'tags');
                  cubit.getCityFilter(endPoint: 'cities');
                  navigateTo(context, const FilterPage());
                },
                icon: const Icon(
                  Icons.filter_list_sharp,
                  size: 27,
                ),
              ),
            ],
          ),
          drawer: Drawer(
            elevation: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: defaultColor,
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bubble_chart_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: DropdownButton(
                      //     isExpanded: true,
                      //     value: dropDownValue,
                      //     icon:  Icon(
                      //       Icons.arrow_drop_down_outlined,
                      //       color: defaultColor,
                      //     ),
                      //     underline: Container(
                      //       height: 2,
                      //       color: defaultColor,
                      //     ),
                      //     items: const [
                      //       DropdownMenuItem(
                      //         value: 'One',
                      //         child: Text('One'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: 'Two',
                      //         child: Text('Two'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: 'Three',
                      //         child: Text('Three'),
                      //       ),
                      //     ],
                      //     onChanged: (value) {},
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: DropdownButton(
                      //     isExpanded: true,
                      //     value: dropDownValue,
                      //     icon:  Icon(
                      //       Icons.arrow_drop_down_outlined,
                      //       color: defaultColor,
                      //     ),
                      //     underline: Container(
                      //       height: 2,
                      //       color: defaultColor,
                      //     ),
                      //     items: const [
                      //       DropdownMenuItem(
                      //         value: 'One',
                      //         child: Text('One'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: 'Two',
                      //         child: Text('Two'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: 'Three',
                      //         child: Text('Three'),
                      //       ),
                      //     ],
                      //     onChanged: (value) {},
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: DropdownButton(
                      //     isExpanded: true,
                      //     value: dropDownValue,
                      //     icon:  Icon(
                      //       Icons.arrow_drop_down_outlined,
                      //       color: defaultColor,
                      //     ),
                      //     underline: Container(
                      //       height: 2,
                      //       color: defaultColor,
                      //     ),
                      //     items: const [
                      //       DropdownMenuItem(
                      //         value: 'One',
                      //         child: Text('One'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: 'Two',
                      //         child: Text('Two'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: 'Three',
                      //         child: Text('Three'),
                      //       ),
                      //     ],
                      //     onChanged: (value) {},
                      //   ),
                      // ),
                      myDivider(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            const Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Icon(
                                CacheHelper.getBoolean(key: 'isDark')?? true
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined),
                            const Spacer(),
                            Switch(
                              value: CacheHelper.getBoolean(key: 'isDark')?? true,
                              activeColor: defaultColor,
                              activeTrackColor: defaultColor.withOpacity(0.5),
                              inactiveThumbColor:defaultColor,
                              onChanged: (value) {
                                HomeLandMarksCubit.get(context).changeThemeMode();
                              },
                            ),
                          ],
                        ),
                      ),
                      myDivider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: (){
                            navigateAndFinish(context, const OnBoardingScreen());
                          },
                          child:  Row(
                            children: [
                              Text(
                                'instructions',
                                style: TextStyle(
                                  color: defaultColor,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              Icon(Icons.arrow_right,color: defaultColor,),
                            ],
                          ),
                        ),
                      ),
                      myDivider(),
                      const Text(
                        'Theme Color',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: SizedBox(
                          height: 125,
                          child: GridView.count(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: (){
                                  cubit.changeColorTheme(Colors.red);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: (){
                                  cubit.changeColorTheme(Colors.green);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeColorTheme(Colors.blue);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeColorTheme(Colors.orange);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: (){
                                  cubit.changeColorTheme(Colors.yellow);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: ()
                                {
                                  cubit.changeColorTheme(Colors.purple);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: ()
                                {
                                  cubit.changeColorTheme(Colors.amber);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 20,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.all(Radius.circular(7))
                                  ),
                                ),
                                onTap: (){
                                  cubit.changeColorTheme(Colors.pink);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      myDivider(),
                        TextButton(
                          onPressed: ()
                          {
                            if(!cubit.isOut) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      shadowColor: Colors.grey,
                                      title: const Center(child: Text(
                                        'Do you want to LOGOUT ?',
                                        style: TextStyle(fontSize: 15),)),
                                      content: Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                              onTap: () {
                                                cubit.signOut();
                                                Navigator.pop(context);
                                                navigateTo(context, LoginPage());
                                                cubit.isUserOut();
                                              },
                                              child: const Text('Yes')),
                                          const Spacer(),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('no')),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                              );
                            }
                            if(cubit.isOut) {
                              navigateTo(context, LoginPage());
                            }
                          },
                          child: cubit.isOut ? Text("LogIn", style: TextStyle(
                            color: defaultColor,
                            fontSize: 20,
                          ),
                          ) : Text(
                            "LogOut",
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      myDivider(),
                    ],
                  )
                ],
              ),
            ),
          ),
          onDrawerChanged:(isOpened) {
            cubit.isUserOut();
          },
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
          body: RefreshIndicator(
            color: defaultColor,
            edgeOffset: 30,
            onRefresh: ()async
            {
                cubit.getMostRecentLandMarks();
                cubit.getRecommendedLandMarks();
                await refresh();
            },
            child: ConditionalBuilder(
              condition: mostRecentModel != null && recommendedRecentModel != null,
              fallback: (context) =>  Center(child: CircularProgressIndicator(color: defaultColor,)),
              builder: (context) {
                return ConditionalBuilder(
                  condition: searchController.text.isEmpty,
                  fallback: (context) => ConditionalBuilder(
                    condition: state is GETSearchStateLoadingStates,
                    fallback: (context) => ConditionalBuilder(
                        condition: cubit.homelandModelSearch!.data.isNotEmpty,
                        fallback: (context) => const Center(child: Text('There is no result')),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                          itemCount: cubit.homelandModelSearch!.data.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) {
                            return searchItemBuilder(
                              context,
                              cubit.homelandModelSearch!.data[index],
                              HomeLandMarksCubit.get(context),
                            );
                          },
                        ),
                      ),
                    ),
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                  ),
                  builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recommended Experiences',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold ,
                                //fontFamily: 'Janna',
                            ),
                          ),
                          const SizedBox(height: 5,),
                          SizedBox(
                            height: 254,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: recommendedRecentModel!.data.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                width: 8,
                              ),
                              itemBuilder: (context, index) {
                                return recommendedItemBuilder(
                                    context,
                                    recommendedRecentModel.data[index],
                                    HomeLandMarksCubit.get(context));
                              },
                            ),
                          ),
                          const Text(
                            'Most Recent',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5,),
                          SizedBox(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: mostRecentModel!.data.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                return mostRecentItemBuilder(
                                    context,
                                  mostRecentModel.data[index],
                                    HomeLandMarksCubit.get(context),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
            ),
          ),
        );
      },
    );
  }
}
