import 'package:flutter/material.dart';

class AppNameAnimation extends StatefulWidget {
  const AppNameAnimation({Key? key}) : super(key: key);

  @override
  _AppNameAnimationState createState() => _AppNameAnimationState();
}

class _AppNameAnimationState extends State<AppNameAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation =
      Tween<double>(begin: 0.00, end: 0.08).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _animation.drive(Tween<Offset>(
            begin: const Offset(0.00, -0.08), end: const Offset(0.00, 0.08))),
        child: Image.asset(
          "android/assets/images/app_name_design.png",
          fit: BoxFit.cover,
          height: 200,
          alignment: Alignment.centerRight,
          width: 200,
        ),
      ),
    );
  }
}
