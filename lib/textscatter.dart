// lib/text_scatter.dart

library text_scatter;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:math';

Color getRandomWhiteColor(Random random) {
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class BobbleBean {
  late Offset postion;
  late Offset speed;
  late Color color;
  late double radius;
  late String character;
  late double stopDistance;
}

class TextScatter extends StatefulWidget {
  final String text;

 const TextScatter({Key? key, this.text = 'Hello, World!'}) : super(key: key);

  @override
  _TextScatterState createState() => _TextScatterState();
}

class _TextScatterState extends State<TextScatter> with TickerProviderStateMixin {
  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);
  late AnimationController _animationController;
  final bool _confirmed = false;
  late AnimationController _dustController;
  late Animation<double> _dustAnimation;
  final List<BobbleBean> _list = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(), () {
      String text = widget.text;
      if (text.length < 10) {
        text = text * (10 ~/ text.length);
      }
      initData(text);
    });

    _dustController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _dustAnimation = Tween(begin: 1.0, end: 0.1).animate(_dustController);
    _dustAnimation.addListener(() {
      setState(() {
        if (_confirmed) {
          _list.forEach((bean) {
            bean.radius *=  _dustAnimation.value;
          });
        }
      });
    });

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
  }

  void initData(String text) {
    for (int i = 0; i < text.length; i++) {
      BobbleBean bean = BobbleBean();
      bean.color = getRandomWhiteColor(_random);

      double angle = _random.nextDouble() * 2 * math.pi;
      double speed = _random.nextDouble() * 2.0 + 1.0;
      double dx = speed * math.cos(angle);
      double dy = speed * math.sin(angle);

      double x = MediaQuery.of(context).size.width / 2;
      double y = MediaQuery.of(context).size.height / 2;
      bean.postion = Offset(x, y);

      bean.speed = Offset(dx, dy);
      bean.radius = 4.0;
      bean.character = text[i];
      bean.stopDistance = _random.nextDouble() * 200 + 50; // The distance at which the character will stop moving.
      _list.add(bean);
    }
  }

  void _confirm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _confirm,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
               Positioned.fill(
                child: Container(color: Colors.blue,)
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 1.0, end: _confirmed ? 0.0 : 1.0),
                duration: const Duration(seconds: 3),
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Opacity(
                    opacity: opacity,
                    child: CustomPaint(
                      size: MediaQuery.of(context).size,
                      painter: SnowCustomMyPainter(list: _list, random: _random),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SnowCustomMyPainter extends CustomPainter {
  List<BobbleBean> list;
  Random random;

  SnowCustomMyPainter({required this.list, required this.random});

  final Paint _paint = Paint()..isAntiAlias = true;

  void paint(Canvas canvas, Size size) {
    list.forEach((element) {
      // If the character has not reached its stop distance, update its position
      if (math.sqrt(math.pow(element.postion.dx - size.width / 2, 2) +
              math.pow(element.postion.dy - size.height / 2, 2)) <
          element.stopDistance) {
        element.postion += element.speed;
      } else {
        // If the character has reached its stop distance, make it tremble slightly
        double dx = random
.nextDouble() * 2.0 - 1.0;
        double dy = random.nextDouble() * 2.0 - 1.0;
        element.postion += Offset(dx, dy);
      }
    });

    list.forEach((element) {
      _paint.color = element.color;
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: element.character,
          style: TextStyle(
            color: element.color,
            fontSize: element.radius * 5,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, element.postion);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}