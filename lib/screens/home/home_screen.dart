import 'package:flutter/material.dart';
import 'package:flutter_political_bias_detector/screens/home/components/results.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/attention.dart';
import '../../components/header.dart';
import 'components/input.dart';
import 'components/top_6.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: bgColor,
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const Header(title: 'Inicio'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Input(formKey: _formKey, textController: _textController),
                        if (Responsive.isMobile(context)) const SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) const Results(),
                        const SizedBox(height: defaultPadding),
                        const IntrinsicAttention(),
                        const Top6(),
                      ],
                    ),
                  ),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context)) const Expanded(flex: 2, child: Results()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
