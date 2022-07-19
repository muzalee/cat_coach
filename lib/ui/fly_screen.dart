import 'package:cat_coach/core/constant/asset_path.dart';
import 'package:cat_coach/provider/fly_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import 'widget/fly.dart';

class FlyScreen extends StatefulWidget {
  final VoidCallback callback;
  const FlyScreen({Key? key, required this.callback}) : super(key: key);

  @override
  _FlyScreenState createState() => _FlyScreenState();
}

class _FlyScreenState extends State<FlyScreen> {
  late FlyProvider _provider;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();

    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      _provider.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlyProvider(),
      child: Consumer<FlyProvider>(
        builder: (context, provider, child) {
          _provider = provider;
          return WillPopScope(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(grassImage),
                      fit: BoxFit.cover
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(splashIcon),
                            fit: BoxFit.cover
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: Text(
                          provider.score.toString(),
                          key: ValueKey<int>(provider.score),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    Fly(x: provider.x, y: provider.y, angle: provider.angle, isTap: provider.isTap, onTap: provider.tap),
                  ],
                ),
              ),
            ),
            onWillPop: onWillPop,
          );
        }
      ),
    );
  }

  //action functions
  Future<bool> onWillPop() async {
    widget.callback.call();
    return true;
  }
}