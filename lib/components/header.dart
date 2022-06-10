import 'package:flutter/material.dart';
import 'package:flutter_political_bias_detector/constants.dart';
import '../responsive.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: bgColor,
      child: Row(
        children: [
          if (!Responsive.isMobile(context)) Text(title, style: Theme.of(context).textTheme.headline6),
          if (!Responsive.isMobile(context)) Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          // const Expanded(child: SearchField()),
          // const ProfileCard()
        ],
      ),
    );
  }
}
