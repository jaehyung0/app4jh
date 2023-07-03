import 'dart:async';

import 'package:aboutfcseoul/MO_FRA/frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  String type = 'football';
  late Timer _timer;
  int _seconds = 0;

  late final AnimationController _ballController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  late final AnimationController _goalController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _goalController = AnimationController(
      duration: const Duration(milliseconds: 40),
      vsync: this,
    )..repeat(reverse: true);
    _startTimer();
    animation = Tween(begin: 0.0, end: 5.0).animate(_goalController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    //_ballController.dispose();
    //_playerController.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        //type = 'football';
        if (_seconds == 1) {
          type = 'player';
        } else if (_seconds == 2) {
          type = 'goal';
        }
      });
      _seconds++;
      if (_seconds == 4) {
        _ballController.dispose();
        _goalController.dispose();
        _timer.cancel();
        Get.off(() => const Frame());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          if (type == 'football')
            AnimatedBuilder(
              animation: _ballController,
              child: Image.asset('assets/images/football.png'),
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: 3 * _ballController.value,
                  child: child,
                );
              },
            ),
          if (type == 'player')
            AnimatedBuilder(
              animation: _ballController,
              child: Image.asset('assets/images/player.png'),
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _ballController.value * 3,
                  child: child,
                );
              },
            ),
          if (type == 'goal')
            AnimatedBuilder(
              animation: animation,
              child: Image.asset('assets/images/goal.png'),
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(animation.value, animation.value),
                  child: child,
                );
              },
            ),
        ],
      ),
    ));
  }
}
