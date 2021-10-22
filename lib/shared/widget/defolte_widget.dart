import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defoltElvationBottom({
  required Function()? onTap,
  required String text,
}) {
  return ElevatedButton(
    onPressed: onTap,
    child: Text(text),
  );
}

Widget defoltTextBottom({
  required Function()? onTap,
  required String text,
}) {
  return TextButton(
    onPressed: onTap,
    child: Text(text),
  );
}

Widget defoltTextForm({
  required context,
  required TextEditingController controler,
  required String? Function(String?)? valedat,
  required String lable,
  required IconData pIcon,
  required TextInputType? type,
  IconData? sIcon,
  Function()? sFOntap,
  Function()? onTap,
  Function(String)? oFS,
  bool isPassword = false,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controler,
    onTap: onTap,
    enabled: isClickable,
    onFieldSubmitted: oFS,
    validator: valedat,
    keyboardType: type,
    obscureText: isPassword,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          18.0,
        ),
      ),
      label: Text(lable),
      prefixIcon: Icon(
        pIcon,
        color: Theme.of(context).colorScheme.primary,
      ),
      suffixIcon: IconButton(
        onPressed: sFOntap,
        icon: Icon(
          sIcon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      labelStyle: Theme.of(context).textTheme.bodyText1,
    ),
  );
}

void navigateaAndFinsh(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => widget),
      (route) => false);
}

void navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => widget,
    ),
  );
}

void toastShow({required String mass, required ToastStatus state}) {
  Fluttertoast.showToast(
      msg: mass,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStatus { SUCCESS, ERROR, WARING }

Color chooseToastColor(ToastStatus state) {
  Color color = Colors.grey;

  switch (state) {
    case ToastStatus.SUCCESS:
      color = Colors.green;

      break;
    case ToastStatus.ERROR:
      color = Colors.red;

      break;
    case ToastStatus.WARING:
      color = Colors.yellow;

      break;
    default:
  }

  return color;
}
