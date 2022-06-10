import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_political_bias_detector/screens/home/components/radar_chart.dart';

import '../../../bloc_provider.dart';
import '../../../blocs/home_bloc.dart';
import '../../../constants.dart';
import 'result_tile.dart';

class Results extends StatelessWidget {
  const Results({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Resultado", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: defaultPadding),
          Center(child: Chart()),
          const SizedBox(height: defaultPadding),
          const _Result(),
        ],
      ),
    );
  }
}

class _Result extends StatelessWidget {
  const _Result({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return StreamBuilder<Result>(
        stream: bloc.result,
        builder: (context, snapshot) {
          final preds = snapshot.data?.predictions ?? {};

          String selected = '';
          if (preds.isNotEmpty) {
            double greatest = preds.values.reduce(max);
            selected = preds.entries.singleWhere((entry) => entry.value == greatest, orElse: () => null)?.key ?? '';
          }

          return Column(
            children: [
              ResultTile(
                  svgSrc: "assets/icons/podemos.svg",
                  title: "Unidas Podemos",
                  desc: 'Izquierda',
                  percentage: preds[Partido.podemos] ?? 0,
                  selected: selected == Partido.podemos),
              ResultTile(
                  svgSrc: "assets/icons/psoe.svg",
                  title: "PSOE",
                  desc: 'Centro-izquierda',
                  percentage: preds[Partido.psoe] ?? 0,
                  selected: selected == Partido.psoe),
              ResultTile(
                  svgSrc: "assets/icons/cs.svg",
                  title: "Ciudadanos",
                  desc: 'Centro',
                  percentage: preds[Partido.ciudadanos] ?? 0,
                  selected: selected == Partido.ciudadanos),
              ResultTile(
                  svgSrc: "assets/icons/pp.svg",
                  title: "Partido Popular",
                  desc: 'Centro-derecha',
                  percentage: preds[Partido.pp] ?? 0,
                  selected: selected == Partido.pp),
              ResultTile(
                  svgSrc: "assets/icons/vox.svg",
                  title: "VOX",
                  desc: 'Derecha',
                  percentage: preds[Partido.vox] ?? 0,
                  selected: selected == Partido.vox),
            ],
          );
        });
  }
}
