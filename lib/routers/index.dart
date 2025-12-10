import 'package:flutter/material.dart';
import 'package:my_app/pages/HomePage.dart';
import 'package:my_app/pages/LoginPage.dart';

Widget getRouterWidget() {
  return MaterialApp(initialRoute: '/', routes: getRouterMap());
}

Map<String, WidgetBuilder> getRouterMap() {
  return {'/': (context) => Homepage(), '/login': (context) => Loginpage()};
}
