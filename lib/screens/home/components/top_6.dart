import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../bloc_provider.dart';
import '../../../blocs/home_bloc.dart';
import '../../../constants.dart';
import '../../../responsive.dart';

class Top6 extends StatelessWidget {
  const Top6({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    final _size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(defaultPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tokens con más peso", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: defaultPadding),
          StreamBuilder<Result>(
              stream: bloc.result,
              builder: (context, snapshot) {
                Map<String, double> _results = _buildResults(snapshot.data);

                return Responsive(
                  mobile: _Result(
                      results: _results, crossAxisCount: _size.width < 650 ? 1 : 2, childAspectRatio: _size.width < 650 && _size.width > 350 ? 7 : 1),
                  tablet: _Result(results: _results, crossAxisCount: 2, childAspectRatio: 4),
                  desktop: _Result(results: _results, childAspectRatio: _size.width < 1400 ? 2 : 4),
                );
              }),
        ],
      ),
    );
  }

  Map<String, double> _buildResults(Result result) {
    final Map<String, double> map = {};

    if (result == null) return map;

    final tokens = result.text.split(' ');
    final attention = result.attention;

    final List<double> attentionAux = List.from(attention);
    final List<String> tokensAux = List.from(tokens);
    double top;
    int index;
    for (var i = 0; i < 6; i++) {
      top = attentionAux.reduce(max);
      index = attentionAux.indexWhere((element) => element == top);
      map[tokensAux.elementAt(index)] = top;
      attentionAux.removeAt(index);
      tokensAux.removeAt(index);
    }

    return map;
  }
}

class _Result extends StatelessWidget {
  const _Result({
    Key key,
    @required this.results,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final Map<String, double> results;
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) => results.isEmpty
      ? Text('Introduce un texto para analizar',
          style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.white70, fontStyle: FontStyle.italic))
      : GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final String text = results.keys.elementAt(index);
            double percentage = (results.values.elementAt(index) * 100);

            return Row(
              children: [
                Text(text),
                const SizedBox(width: defaultPadding),
                Expanded(child: ProgressLine(percentage: percentage.round())),
                const SizedBox(width: defaultPadding / 2),
                Text('${percentage.toStringAsFixed(2)}%', style: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.white60)),
              ],
            );
          },
        );
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
    this.color = primaryColor,
    @required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
