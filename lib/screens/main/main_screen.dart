import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_political_bias_detector/blocs/home_bloc.dart';
import 'package:flutter_political_bias_detector/screens/home/home_screen.dart';
import 'package:flutter_political_bias_detector/screens/model/model_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc_provider.dart';
import '../../blocs/main_bloc.dart';
import '../../responsive.dart';
import 'components/main_drawer.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageList = <Widget>[
    BlocProvider<HomeBloc>(
      initBloc: (bloc) => bloc ?? HomeBloc(),
      child: HomeScreen(),
      onDispose: (bloc) => bloc?.dispose(),
    ),
    const ModelScreen(),
    const Center(child: Text('3')),
  ];

  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MainBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: SvgPicture.asset("assets/icons/menu.svg", color: Colors.white70),
                onPressed: () {
                  if (!_scaffoldKey.currentState.isDrawerOpen) {
                    _scaffoldKey.currentState.openDrawer();
                  }
                },
              ),
            )
          : null,
      drawer: StreamBuilder<int>(
          initialData: 0,
          stream: bloc.pageIndex,
          builder: (context, snapshot) => MainDrawer(currentIndex: snapshot.data, setPageIndex: bloc.setPageIndex)),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: StreamBuilder<int>(
                  initialData: 0,
                  stream: bloc.pageIndex,
                  builder: (context, snapshot) => MainDrawer(
                    currentIndex: snapshot.data,
                    setPageIndex: bloc.setPageIndex,
                  ),
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: PageTransitionSwitcher(
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: StreamBuilder<int>(
                  initialData: 0,
                  stream: bloc.pageIndex,
                  builder: (context, snapshot) => _pageList[snapshot.data],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
