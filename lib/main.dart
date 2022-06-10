import 'package:flutter/material.dart';
import 'package:flutter_political_bias_detector/bloc_provider.dart';
import 'package:flutter_political_bias_detector/blocs/main_bloc.dart';
import 'package:flutter_political_bias_detector/constants.dart';
import 'package:flutter_political_bias_detector/screens/main/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analizador de inclinación política',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: BlocProvider<MainBloc>(
        child: MainScreen(),
        initBloc: (bloc) => bloc ?? MainBloc(),
        onDispose: (bloc) => bloc.dispose(),
      ),
    );
  }
}
