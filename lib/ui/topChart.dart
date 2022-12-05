import 'dart:js';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rate/ui/pieChart.dart';

class Top3Chart extends StatefulWidget {
  final String image;
  final String name;
  double rate;
  int win;
  int lose;
  bool allow = false;

  Top3Chart({
    required this.image,
    required this.name,
    required this.rate,
    required this.win,
    required this.lose,
    required this.allow,
  });

  @override
  State<Top3Chart> createState() =>
      _Top3ChartState();
}

class _Top3ChartState
    extends State<Top3Chart>
    with
        SingleTickerProviderStateMixin {
  late AnimationController
      _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // 애니메이션 컨트롤러 초기화
    _animationController =
        AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds:
              2000), // 300 밀리세컨드, 0.3 초간 실행
    );

    // _animationController에서 지정하는 범위내에서 90 에서 0 으로 점차 값이 변화한다.
    _animation = Tween<double>(
            begin: 2 *
                (widget.rate / 100) *
                pi,
            end: 0)
        .animate(_animationController);

    // repeat를 이용해 애니메이션을 반복한다.

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allow = false) {
      _animationController.reset();
      _animationController.stop();
    } else {
      Future.delayed(
          const Duration(
              milliseconds: 1200), () {
        _animationController.forward();
      });
    }

    _animationController.reset();
    return Container(
      width: 750,
      height: 200,
      color: Colors.white,
      child: Row(children: [
        Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: Align(
              alignment: Alignment
                  .bottomCenter,
              child: Container(
                  width: 200,
                  height: 40,
                  color:
                      Colors.deepOrange,
                  child: Text(
                      '${widget.allow}',
                      style: TextStyle(
                          fontSize: 20),
                      textAlign:
                          TextAlign
                              .center))),
        ),
        Container(
            width: 300,
            height: 200,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              children: [
                Container(
                  child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,
                      children: <
                          Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .amber,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .amber,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .amber,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .amber,
                        ),
                      ]),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,
                      children: [
                        Text(
                          '승률: ${widget.rate}%',
                          style: TextStyle(
                              fontSize:
                                  30),
                        ),
                        Text(
                          '${widget.win} 승',
                          style: TextStyle(
                              fontSize:
                                  30),
                        ),
                        Text(
                          '${widget.lose} 패',
                          style: TextStyle(
                              fontSize:
                                  30),
                        ),
                      ]),
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(
                left: 50)),
        CustomPaint(
          size: Size(150, 150),
          painter: PieChart(
              percentage: widget.rate,
              textScaleFactor: 1.0,
              draw: _animation),
        )
      ]),
    );
  }
}
