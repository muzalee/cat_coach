import 'dart:async';

import 'package:cat_coach/core/services/shared_pref.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String _name = '';
  final List<int> _list = [0, 0, 0];

  String get name => _name;
  List<int> get list => _list;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  Future<void> getName() async {
    name = await SharedPref.getName();
  }

  Future<void> getValue(String name, int index) async {
    _list[index] = await SharedPref.getScore(name);
    notifyListeners();
  }
}