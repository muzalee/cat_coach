import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cat_coach/core/services/shared_pref.dart';
import 'package:cat_coach/core/util/enum.dart';
import 'package:flutter/material.dart';

class CockroachProvider extends ChangeNotifier {
  double _x = 1.1;
  double _y = 0;
  bool _isTap = false;
  int _score = 0;
  int _angle = 270;
  Direction _directionX = Direction.up;
  Direction _directionY = Direction.straight;

  late Timer _timer;

  double get x => _x;
  double get y => _y;
  bool get isTap => _isTap;
  int get score => _score;
  int get angle => _angle;

  set x(double value) {
    _x = value;
    notifyListeners();
  }

  set y(double value) {
    _y = value;
    notifyListeners();
  }

  set isTap(bool value) {
    _isTap = value;
    notifyListeners();
  }

  set score(int value) {
    _score = value;
    notifyListeners();
  }

  set angle(int value) {
    _angle = value;
    notifyListeners();
  }

  Future<void> init() async {
    score = await SharedPref.getScore('cockroach');
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      move();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void move() {
    if (!_isTap) {
      if (_directionX == Direction.up && _x > -1.1) {
        x -= 0.005;
      } else if (_directionX == Direction.down && _x < 1.1) {
        x  += 0.005;
      } else {
        setRandom();
      }

      if (_directionY == Direction.right && _y > -1.3) {
        y -= 0.0025;
      } else if (_directionY == Direction.left && _y < 1.3) {
        y  += 0.0025;
      } else if (_directionY != Direction.straight) {
        setRandom();
      }
    }
  }

  void setRandom() {
    Random random = Random();
    int xPos = random.nextInt(2);
    if (xPos == 0) {
      x = 1.1;
      _directionX = Direction.up;
    } else {
      x = -1.1;
      _directionX = Direction.down;
    }

    int yPos = random.nextInt(3);
    if (yPos == 0) {
      _directionY = Direction.straight;
    } else if (yPos == 1) {
      _directionY = Direction.left;
    } else {
      _directionY = Direction.right;
    }

    y = -1 + (1 - -1) * random.nextDouble();

    if (_directionX == Direction.up && _directionY == Direction.straight) {
      angle = 270;
    } else if (_directionX == Direction.down && _directionY == Direction.straight) {
      angle = 90;
    } else if (_directionX == Direction.up && _directionY == Direction.left) {
      angle = 250;
    } else if (_directionX == Direction.down && _directionY == Direction.left) {
      angle = 110;
    } else if (_directionX == Direction.up && _directionY == Direction.right) {
      angle = 300;
    } else if (_directionX == Direction.down && _directionY == Direction.right) {
      angle = 60;
    }
  }

  Future<void> tap() async {
    if (!_isTap) {
      isTap = true;

      SharedPref.setScore('cockroach');
      score++;

      final AudioPlayer player = AudioPlayer();
      player.play(AssetSource('audio/squeky.mp3'));

      Future.delayed(const Duration(milliseconds: 2000), () {
        isTap = false;
        setRandom();
      });
    }
  }
}