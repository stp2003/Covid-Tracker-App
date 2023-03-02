import 'dart:async';
import 'dart:math' as math;

import 'package:covid_tracker_app/screens/world_stats_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //** defining animation controller and duration ->
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  //?? init state ->
  @override
  void initState() {
    super.initState();

    //** for going to WorldStatsScreen ->
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WorldStatsScreen(),
        ),
      ),
    );
  }

  //?? dispose ->
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  //?? build ->
  @override
  Widget build(BuildContext context) {
    //** media query ->
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //?? for animation ->
            AnimatedBuilder(
              animation: animationController,
              child: SizedBox(
                height: 200.0,
                width: 200.0,
                child: Center(
                  child: Image.asset('assets/images/virus.png'),
                ),
              ),
              builder: (context, Widget? child) {
                return Transform.rotate(
                  angle: animationController.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),

            //****
            SizedBox(height: size.height * 0.1),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Covid-19 Tracker',
                style: TextStyle(
                  fontFamily: 'poppins_medium',
                  fontSize: 22.0,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
