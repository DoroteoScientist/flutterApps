import 'package:flutter/material.dart';
import 'package:flutter_application_1/scripts/dashboard_screen.dart';
import 'package:flutter_application_1/scripts/challenge_screen.dart';
import 'package:flutter_application_1/scripts/detail_popular_movie_screen.dart';
import 'package:flutter_application_1/scripts/popular_screen.dart';
import 'package:flutter_application_1/scripts/tema_settings.dart';
import 'package:flutter_application_1/scripts/favs_screen.dart';
//import 'package:flutter_application_1/scripts/contador_screen.dart';
import 'package:flutter_application_1/scripts/login_screen.dart';
import 'package:flutter_application_1/utils/global_values.dart';


void main() => runApp(MyApp());

//Materiall App es la raiz de todas las pantallas, este genrelamen esta en el main
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,//ESTO escuchara la variable que cambiara y reconstruira todo estyo
      builder: (context, value, widget) {
        return MaterialApp(
          //theme: value == 1?ThemeData.light():ThemeData.dark(),//oscuro
          theme: TemaSettings.setTheme(value),
          //theme: ThemeData.light(),//brilloso
          //title: 'Material App',
          home: const LoginScreen(),
          //esto tiene que ver con un mapa y sus inidces asociativos       
          routes: {
            "/dash" : (context) => const DashboardScreen(),
            "/reto" : (context) => const ChallengeScreen(),
            "/api" : (context) => const PopularScreen(),
            "/detail" : (context) => const DetailPopularMovieScreen(),
            '/favorites': (context) => const FavoritesScreen(),
          
            },
        );
      }
    );
  }
}

//areglos indexados y asociativos
