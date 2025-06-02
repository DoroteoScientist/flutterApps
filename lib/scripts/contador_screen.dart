import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContadorScreen extends StatefulWidget {
  const ContadorScreen({super.key});

  @override
  State<ContadorScreen> createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  var contador = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AAAAA', style: TextStyle(color: Color(0xFFFFFFFF)),),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text('Valor del contador', style: TextStyle(fontSize: 25, color: Color.fromARGB(10, 2, 2, 3)),)
        ,),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ads_click),
          onPressed:(){
            contador++;
            print(contador);
            //decir que se va a renderizar la pantallam de nueva cuenta
            setState(() {
              
            });
          }
      ),
    );}
}