import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

class BarChart extends StatefulWidget {
  int rank = 0;
  double rate = 0;
  final String champ;
  bool allow = false;

  BarChart({
    required this.rank,
    required this.champ,
    required this.rate,
    required this.allow,
  });

  @override
  State<BarChart> createState() =>
      _BarChartState();
}

class _BarChartState
    extends State<BarChart>
    with
        SingleTickerProviderStateMixin {
  late AnimationController Control;
  late Animation<double> anime;

  @override
  void initState() {
    // 애니메이션 컨트롤러 초기화
    Control = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds:
              2000), // 300 밀리세컨드, 0.3 초간 실행
    );

    // _animationController에서 지정하는 범위내에서 90 에서 0 으로 점차 값이 변화한다.
    anime = Tween<double>(
            begin: widget.rate, end: 0)
        .animate(Control);

    // repeat를 이용해 애니메이션을 반복한다.

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allow = false) {
      Control.reset();
      Control.stop();
    } else {
      Future.delayed(
          const Duration(
              milliseconds: 1200), () {
        Control.forward();
      });
    }

    List<VBarChartModel> bardata = [
      VBarChartModel(
        index: widget.rank,
        label: widget.champ,
        colors: [
          Color(0xfff93f5b),
          Color(0xfff93f5b)
        ],
        jumlah:
            widget.rate - anime.value,
        tooltip: "${widget.rate}",
      ),
    ];

    return Container(
      child: _buildGrafik(bardata),
    );
  }
}

Widget _buildGrafik(
    List<VBarChartModel> bardata) {
  return VerticalBarchart(
    background: Colors.transparent,
    labelColor: Color(0xff283137),
    tooltipColor: Color(0xff8e97a0),
    maxX: 100,
    data: bardata,
    barStyle: BarStyle.DEFAULT,
    barSize: 20,
  );
}
