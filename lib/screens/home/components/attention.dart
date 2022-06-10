import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../bloc_provider.dart';
import '../../../blocs/home_bloc.dart';
import '../../../constants.dart';

class IntrinsicAttention extends StatelessWidget {
  const IntrinsicAttention({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(defaultPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Intrinsic attention", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: defaultPadding),
          StreamBuilder<Result>(
            stream: bloc.result,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Text('Introduce un texto para analizar',
                    style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.white70, fontStyle: FontStyle.italic));
              }

              final textStyle = Theme.of(context).textTheme.bodyMedium;
              List<Widget> tokens = List.from(
                snapshot.data.text.split(' ').mapIndexed(
                      (index, token) => Text('$token ',
                          style: textStyle.copyWith(
                              color: Colors.white.withOpacity(0.87), backgroundColor: Colors.blue.withOpacity(snapshot.data.attention[index]))),
                    ),
              );
              return _IntrinsicAttention(tokens: tokens);
            },
          ),
        ],
      ),
    );
  }
}

class _IntrinsicAttention extends StatelessWidget {
  final List<Widget> tokens;

  const _IntrinsicAttention({Key key, @required this.tokens}) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(direction: Axis.horizontal, children: tokens);
}
