import 'package:cat_coach/core/constant/asset_path.dart';
import 'package:cat_coach/core/util/struct.dart';
import 'package:cat_coach/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cockroach_screen.dart';
import 'fly_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider _provider;

  final List<Menu> _list = [
    Menu('cockroach', cockroachMainIcon, null, [Colors.lightBlueAccent, Colors.purpleAccent]),
    Menu('fly', flyMainIcon, null, [Colors.red, Colors.yellow]),
    Menu('', '', null, [])
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            _provider = provider;
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset(profileIcon, height: 40),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text("Hello", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Choose what you'd like to destroy"),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _list.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: _buildMenu(index),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  //widget functions
  Widget _buildMenu(int index) {
    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      _provider.getValue(_list[index].name, index);
    });

    if (_list[index].widget == null) {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey,
                Colors.black,
              ],
            ),
          ),
          child: const Text("Not Available", style: TextStyle(color: Colors.white, fontSize: 16),),
        )
      );
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _list[index].widget!)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                _list[index].color[0],
                _list[index].color[1],
              ],
            ),
          ),
          child: Stack(
            children: [
              Image.asset(_list[index].asset),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black,
                ),
                child: Text('${_provider.list[index]} destroyed', style: const TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  //local functions
  void init() {
    _list[0].widget = CockroachScreen(callback: () => callback(0));
    _list[1].widget = FlyScreen(callback: () => callback(1));
  }

  void callback(int index) {
    _provider.getValue(_list[index].name, index);
  }
}