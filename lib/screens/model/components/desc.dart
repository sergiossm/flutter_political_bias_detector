import 'package:flutter/material.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Descripción", style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: defaultPadding),
          Text(
              'En este Trabajo de Fin de Grado se analiza el proceso de entrenamiento y despliegue de un modelo de Natural language processing (NLP) destinado a la detección automática de inclinación política en medios de comunicación. Para tal fin, se ha construido un dataset adecuado y se ha entrenado con éste una red neuronal artificial siguiendo estándares del estado del arte.\n\nEl dataset lo conforman las intervenciones de todos los miembros de los cinco partidos mayoritarios del país en el Congreso de los Diputados durante las últimas tres legislaturas. Después se han aplicado técnicas de pre-procesamiento de datos para adaptarlo al entrenamiendo de nuestro modelo.\n\nUna vez construido el conjunto de datos, se han aplicado técnicas de transfer learning para crear un clasificador específico partiendo de un modelo de lenguaje genérico en español. Después, se han implementado procesos para estudiar la explicabilidad del modelo.\n\nPosteriormente, se han explorado las diversas alternativas de despliegue en producción del modelo y optado por la idónea, que ha sido la creación de una API REST en un contenedor online de imágenes. Para la utilización de este servicio se ha desarrollado una interfaz gráfica en forma de aplicación multiplaforma (Android, iOS y web).',
              style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.white.withOpacity(0.87), letterSpacing: 0.15, height: 1.35)),
        ],
      ),
    );
  }
}
