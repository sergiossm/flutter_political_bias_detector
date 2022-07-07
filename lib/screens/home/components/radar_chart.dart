import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radar_chart/radar_chart.dart';

import '../../../bloc_provider.dart';
import '../../../blocs/home_bloc.dart';
import '../../../constants.dart';

class Chart extends StatelessWidget {
  final int _length = 5;
  final List<double> _initialData = [0, 0, 0, 0, 0];

  Chart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return StreamBuilder<Result>(
        stream: bloc.result,
        builder: (context, snapshot) {
          List<double> values = _initialData;

          if (snapshot.data != null) {
            Map<String, double> preds = snapshot.data.predictions.map((key, value) => MapEntry(key, value / 100));

            values.clear();
            values.addAll([
              preds[Partido.ciudadanos],
              preds[Partido.podemos],
              preds[Partido.psoe],
              preds[Partido.pp],
              preds[Partido.vox],
            ]);
          }

          return RadarChart(
            length: _length,
            radius: 100,
            initialAngle: pi / 2,
            backgroundColor: bgColor,
            borderStroke: 2,
            borderColor: Colors.white70,
            vertices: [
              PreferredSize(
                  child: SvgPicture.asset('assets/icons/cs-alt.svg', color: Colors.white54, width: 30, height: 30), preferredSize: const Size(25, 0)),
              PreferredSize(
                  child: SvgPicture.asset('assets/icons/podemos-alt.svg', color: Colors.white54, width: 30, height: 30),
                  preferredSize: const Size(70, 35)),
              PreferredSize(
                  child: SvgPicture.asset('assets/icons/psoe-alt.svg', color: Colors.white54, width: 30, height: 30),
                  preferredSize: const Size(70, 50)),
              PreferredSize(
                  child: SvgPicture.asset('assets/icons/pp-alt.svg', color: Colors.white54, width: 30, height: 30), preferredSize: const Size(0, 50)),
              PreferredSize(
                  child: SvgPicture.asset('assets/icons/vox-alt.svg', color: Colors.white54, width: 30, height: 30),
                  preferredSize: const Size(0, 30)),
            ],
            radialColor: Colors.grey,
            radars: [
              RadarTile(
                values: values,
                borderStroke: 2,
                borderColor: Colors.blue,
                backgroundColor: Colors.blue.withOpacity(0.4),
              ),
            ],
          );
        });
  }
}
