import 'package:flutter/material.dart';
import 'package:flutter_political_bias_detector/screens/model/components/characteristics.dart';
import 'package:flutter_political_bias_detector/screens/model/components/conf_matrices.dart';
import 'package:flutter_political_bias_detector/screens/model/components/desc.dart';

import '../../components/header.dart';
import '../../constants.dart';
import '../../responsive.dart';
import 'components/accuracy.dart';

class ModelScreen extends StatelessWidget {
  const ModelScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: bgColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(title: 'Modelo'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        const Description(),
                        if (Responsive.isMobile(context)) const SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) const Characteristics(),
                        const SizedBox(height: defaultPadding),
                        const Accuracies(),
                        if (Responsive.isMobile(context)) const ConfusionMatrices(),
                      ],
                    ),
                  ),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: const [
                          Characteristics(),
                          ConfusionMatrices(),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
