import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class UtilsUI{

   double setWidth(double value){return value.w;}
   double setHeight(double value){ return value.h;}
   double setSp(double value) {return value.sp;}
   double screenWidth(BuildContext context) { return MediaQuery.of(context).size.width;}
   double screenHeight(BuildContext context) {return MediaQuery.of(context).size.height;}
   String screenCekDevice(BuildContext context) {
      logger.i('screenWidth : ${MediaQuery.of(context).size.width}');
      logger.i('screenHeight : ${MediaQuery.of(context).size.height}');
     return 'screenWidth : ${MediaQuery.of(context).size.width} \n screenHeight : ${MediaQuery.of(context).size.height}';
   }

}
final utilsUI = UtilsUI();
final logger = Logger();