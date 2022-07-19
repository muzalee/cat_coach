import 'dart:math';

import 'package:cat_coach/core/constant/asset_path.dart';
import 'package:flutter/material.dart';

class Fly extends StatelessWidget {
  final double x;
  final double y;
  final int angle;
  final bool isTap;
  final VoidCallback onTap;
  const Fly({Key? key, required this.x, required this.y, required this.angle,
    required this.isTap, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: GestureDetector(
        onTap: onTap,
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Image.asset(isTap ? flyDeadIcon : flyIcon, height: 70),
        ),
      ),
    );
  }
}