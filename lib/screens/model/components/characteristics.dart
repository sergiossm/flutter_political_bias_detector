import 'package:flutter/material.dart';

import '../../../constants.dart';

class Characteristics extends StatelessWidget {
  const Characteristics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Características", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Title(title: 'Arquitectura'),
                  Title(title: 'Dimensionalidad'),
                  Title(title: 'Tamaño vocab'),
                  Title(title: 'Tokenizer'),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Label(label: '4 QRNN'),
                  Label(label: '1500'),
                  Label(label: '15 000 tokens'),
                  Label(label: 'SentencePiece'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String label;

  const Label({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.white.withOpacity(0.87))),
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Text(title, style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.white70)),
    );
  }
}
