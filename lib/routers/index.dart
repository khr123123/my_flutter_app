import 'package:flutter/material.dart';
import 'package:my_app/pages/home/HomePage.dart';
import 'package:my_app/pages/login/LoginPage.dart';

Widget getRouterWidget() {
  return MaterialApp(initialRoute: '/', routes: getRouterMap());
}

Map<String, WidgetBuilder> getRouterMap() {
  return {'/': (context) => Homepage(), '/login': (context) => Loginpage()};
}
