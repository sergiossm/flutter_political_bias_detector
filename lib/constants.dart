import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

const partidos = {
  Partido.podemos: {
    'nombre': 'Unidas Podemos',
    'color': Color(0xFF9875FF),
  },
  Partido.psoe: {
    'nombre': 'PSOE',
    'color': Color(0xFFEF8F8F),
  },
  Partido.ciudadanos: {
    'nombre': 'Ciudadanos',
    'color': Color(0xFFFCBB86),
  },
  Partido.pp: {
    'nombre': 'PP',
    'color': Color(0xFF80B4FF),
  },
  Partido.vox: {
    'nombre': 'VOX',
    'color': Color(0xFF9AE4A7),
  },
};

class Partido {
  static const String podemos = 'GCUP-EC-GC';
  static const String psoe = 'GS';
  static const String ciudadanos = 'GCs';
  static const String pp = 'GP';
  static const String vox = 'GVOX';
}
