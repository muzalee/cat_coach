import 'package:flutter/widgets.dart';

class Menu {
  String name;
  String asset;
  Widget? widget;
  List<Color> color;

  Menu(this.name, this.asset, this.widget, this.color);
}