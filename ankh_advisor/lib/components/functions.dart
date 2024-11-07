import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (route) {return false;},
);


enum ToastState{SUCCESS,WRONG,WARNING}
Color chooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WRONG:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({required String text,required ToastState state})
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
  );
}


int getAverage(List<int> numbers) {
  if (numbers.isEmpty) {
    return 0; // To handle division by zero if the list is empty
  }

  int sum = 0;
  for (int number in numbers) {
    sum += number;
  }

  return sum ~/ numbers.length;
}

// voidsignOut()
// {
//
// }