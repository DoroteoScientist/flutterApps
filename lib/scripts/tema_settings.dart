import 'package:flutter/material.dart';

class TemaSettings {
  static ThemeData? setTheme(int opcTheme)
  { 
    switch(opcTheme){
      case 0: return ThemeData.light();
      case 1: return ThemeData.light();
      case 2: {final theme = ThemeData.light().copyWith(
    colorScheme : const ColorScheme(brightness: Brightness.light, 
      primary: Color.fromARGB(256, 156, 114, 111), 
      onPrimary: Colors.yellow, 
      secondary:  Colors.orange,
      onSecondary:  Colors.red, 
      error: Colors.red, 
      onError:  Colors.red,
      surface:  Colors.green,
      onSurface:  Colors.white,)
  );
    return theme;
}
  }
}
}

//un celular necvesiuta una palicacion de por medio para conectarse
//a una base de datos, y por lo tanto un socket no es suficiente
//Aqui se usa algo llamado API, el cual corre en un server
//al exterior expone URL s o endpoints
//con estas URLs se puiede acceder a informacion
//API REST protocolo reglas para la comunicaicon de datos
//port 443 httpa
//get 
//el cache puede traer recursos para facilitar su acceso\
//get(select), post(insert), put(update) y delete(delete)
//token autentication
//JSON web token: 