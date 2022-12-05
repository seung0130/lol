import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'dart:async';

import 'package:rate/ui/barChart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:rate/ui/topChart.dart';
import 'package:rate/ui/lineChart.dart';
import 'package:rate/ui/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChampRate extends StatefulWidget {
  const ChampRate({super.key});

  @override
  State<ChampRate> createState() =>
      _ChampRateState();
}

class _ChampRateState
    extends State<ChampRate>
    with
        SingleTickerProviderStateMixin {
  bool ani = false;
  int barAnime = 0;
  var ov = 0.0;
  int count = 0;
  bool _trigger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("챔피언 승률"),
        ),
        body: ListView(children: [
          Column(
            children: <Widget>[
              Center(
                child: Container(
                  color:
                      Colors.green[100],
                  padding:
                      EdgeInsets.zero,
                  child:
                      AnimatedContainer(
                    width: _trigger
                        ? 1500.0
                        : 0.0,
                    height: _trigger
                        ? 2000.0
                        : 0.0,

                    //
                    //
                    // ignore: sort_child_properties_last
                    child:
                        AnimatedOpacity(
                            opacity: ov,
                            duration: Duration(
                                milliseconds:
                                    650),
                            child: Column(
                                children: <
                                    Widget>[
                                  for (int i = 0;
                                      i < 3;
                                      i++) ...[
                                    Padding(padding: EdgeInsets.only(top: 50)),
                                    Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        elevation: 11.0,
                                        child: Top3Chart(image: '', name: chamName[i], rate: winCount[i], win: 0, lose: 0, allow: ani)),
                                  ],
                                  Padding(
                                      padding: EdgeInsets.only(top: 50)),
                                  Container(
                                    width:
                                        750,
                                    color:
                                        Colors.white,
                                    child:
                                        Column(children: [
                                      for (int i = 0; i < winCount.length; i++) ...[
                                        BarChart(
                                          rank: i,
                                          champ: chamName[i],
                                          rate: winCount[i],
                                          allow: ani,
                                        )
                                      ]
                                    ]),
                                  )
                                ])),
//
//
                    duration: Duration(
                        milliseconds:
                            1000),
                    curve: Curves
                        .easeInCubic,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton
                    .styleFrom(),
                child: Text(
                  "승률 확인하기 $ov $count $ani",
                  style: TextStyle(
                      fontSize: 30),
                ),
                onPressed: () =>
                    setState(() {
                  count++;
                  _trigger = !_trigger;
                  ani = !ani;
                  if (ov == 1.0 &&
                      count % 2 == 0) {
                    ov = 0.0;
                  }
                  if (ov == 0.0 &&
                      count % 2 == 1) {
                    Future.delayed(
                        const Duration(
                            milliseconds:
                                1100),
                        () {
                      setState(() {
                        ov = 1.0;
                      });
                    });
                  }
                }),
              ),
            ],
          ),
        ]));
  }
}

List<double> winCount = [
  90,
  50,
  10,
  30,
  55,
  80
];

List<String> chamName = [
  "에쉬",
  "가렌",
  "다리우스",
  "소라카",
  "야스오",
  "에니비아"
];
