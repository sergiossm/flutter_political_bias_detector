import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../responsive.dart';

class MainDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) setPageIndex;

  const MainDrawer({
    Key key,
    @required this.currentIndex,
    @required this.setPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('🧠\nAnalizador de inclinación política', style: Theme.of(context).textTheme.headlineSmall.copyWith(height: 1.4))),
          DrawerListTile(
            title: "Inicio",
            svgSrc: "assets/icons/home.svg",
            selected: currentIndex == 0,
            press: () {
              if (!Responsive.isDesktop(context)) Navigator.of(context).pop();
              setPageIndex(0);
            },
          ),
          DrawerListTile(
            title: "Modelo",
            svgSrc: "assets/icons/model.svg",
            selected: currentIndex == 1,
            press: () {
              if (!Responsive.isDesktop(context)) Navigator.of(context).pop();
              setPageIndex(1);
            },
          ),
          DrawerListTile(
            title: "Dataset",
            svgSrc: "assets/icons/dataset.svg",
            selected: currentIndex == 2,
            press: () {
              if (!Responsive.isDesktop(context)) Navigator.of(context).pop();
              setPageIndex(2);
            },
          ),
          DrawerListTile(
            title: "Sobre mí",
            svgSrc: "assets/icons/user.svg",
            selected: currentIndex == 3,
            press: () {
              if (!Responsive.isDesktop(context)) Navigator.of(context).pop();
              setPageIndex(3);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    @required this.title,
    @required this.svgSrc,
    @required this.selected,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final bool selected;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          color: selected ? Colors.white70 : Colors.white38,
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : Colors.white54),
        ),
      );
}
