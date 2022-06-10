import 'package:flutter/material.dart';

import '../../../constants.dart';

class ConfusionMatrices extends StatelessWidget {
  const ConfusionMatrices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: LayoutBuilder(builder: (context, constraints) {
        double side = (constraints.maxWidth - defaultPadding) / 2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Matriz de confusión", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                ConfusionMatrix(title: 'Forward', side: side, asset: 'conf-mat-fwd.png'),
                const SizedBox(width: defaultPadding),
                ConfusionMatrix(title: 'Backward', side: side, asset: 'conf-mat-bwd.png'),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class ConfusionMatrix extends StatelessWidget {
  const ConfusionMatrix({
    Key key,
    @required this.side,
    @required this.title,
    @required this.asset,
  }) : super(key: key);

  final double side;
  final String title, asset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white70)),
        Container(
          margin: const EdgeInsets.only(top: defaultPadding / 2),
          height: side,
          width: side,
          color: Colors.white70,
          child: Image.asset('assets/images/$asset'),
        ),
      ],
    );
  }
}
