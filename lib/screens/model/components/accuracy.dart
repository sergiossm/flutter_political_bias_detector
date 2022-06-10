import 'package:flutter/material.dart';

import '../../../constants.dart';

class Accuracies extends StatelessWidget {
  const Accuracies({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Precisión", style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: defaultPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              double width = (constraints.maxWidth - defaultPadding * 2) / 2;

              return Row(
                children: [
                  Accuracy(
                    width: width,
                    title: 'Forward',
                    globalAcc: 0.8801,
                    accMap: const {'GCUP-EC-GC': 0.8941, 'GS': 0.9417, 'GCs': 0.8717, 'GP': 0.8517, 'GVOX': 0.9175},
                  ),
                  const SizedBox(width: defaultPadding * 2),
                  Accuracy(
                    width: width,
                    title: 'Backward',
                    globalAcc: 0.8801,
                    accMap: const {'GCUP-EC-GC': 0.8941, 'GS': 0.9417, 'GCs': 0.8717, 'GP': 0.8517, 'GVOX': 0.9175},
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class Accuracy extends StatelessWidget {
  const Accuracy({
    Key key,
    @required this.title,
    @required this.width,
    @required this.globalAcc,
    @required this.accMap,
  }) : super(key: key);

  final String title;
  final double width, globalAcc;
  final Map<String, double> accMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white70)),
        Container(
          margin: const EdgeInsets.only(top: defaultPadding / 2),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Percentage(
                percentage: globalAcc,
                minHeight: 6,
                textColor: Colors.white.withOpacity(.87),
              ),
              ...accMap.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(partidos[entry.key]['nombre'].toString(), style: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.white70)),
                      Percentage(percentage: entry.value, color: partidos[entry.key]['color']),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Percentage extends StatelessWidget {
  const Percentage({
    Key key,
    @required this.percentage,
    this.minHeight,
    this.color,
    this.textColor = Colors.white70,
  }) : super(key: key);

  final double percentage, minHeight;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: minHeight,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: Text('${(percentage * 100).toStringAsFixed(2)}%', style: Theme.of(context).textTheme.bodyMedium.copyWith(color: textColor)),
        ),
      ],
    );
  }
}
