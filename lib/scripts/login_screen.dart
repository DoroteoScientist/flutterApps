import 'package:flutter/material.dart';
//import 'package:flutter_application_1/scripts/dashboard_screen.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() =>  LoginScreenState();
}

class  LoginScreenState extends State<LoginScreen> {
  TextEditingController cmUser = TextEditingController();//recuperar usuario
  TextEditingController cmPasswd = TextEditingController();//recuperar contrasena
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Container
        (
         
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height,//para esto se recata al resolucion de la pantalla
          //se agarra el valor del contexto, y se establece el tamano por lo menos de la altura
          decoration : const BoxDecoration(
            image : DecorationImage(
              fit : BoxFit.cover,//ajusta el tamnano de una imagen
              image : AssetImage('maincra.jpg'),//agrega una imagen al fondo
            )
          ),
          
          child: Stack(
            alignment : Alignment.center,
            children: [//cuando se trabajan Container, si el container no se le especifican dimensiones
            //se ajusta al contenido 

              Positioned(
                 top : 100,
                child: Image.asset('assets/logo.png'), width: 300),
              Positioned(
                bottom : 250,
                child : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color : Colors.white,
                    borderRadius : BorderRadius.circular(10),
                  ),
                  width: 400,  
                  //height: 150,
                  //height: 150, si agregamos un listView y una columnna, se estiran, si se le quita 
                  // se expandiran pro toda la pantalla 
                  child : ListView(//similar alVBOX
                      //hace que paraezcan los elementos del listview
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          //quien agarra eso, controladr
                          controller: cmUser,
                          // especificar tipo de teclado
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: Text("Nombre de usuario"),//forma de poner texto en la caja de texto
                            //hintText: "Contrasena",//este se reemplaza
                            //por presentacion se recomienda el segundo
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 10,),
                        //Container(), forma de separar elementos
                        //Divider(), forma de separar elementos
                        TextFormField(
                          controller: cmPasswd,
                          obscureText: true,//visibiliza el texto o no
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Text("Contrasena"),
                            border: OutlineInputBorder()
                          ),
                        ),
                      ],
                  )
                  )
              ),    
          
          InkWell(
            onTap: ()
            {
              isLoading = true;
              setState(() {});

             
              
              //implementacions de hilos
              Future.delayed(Duration(seconds: 4)).then((value)
              {
              //cambio de pantalla
              Navigator.pushNamed(context,"/dash");

              }
              );

              //parametros nombrados, aqui su posicion no importa
            /*
              Navigator.push(
                context,
                MaterialPageRoute(builder:  (context)=> const DashboardScreen()),
              );
              */
              },
            child : Positioned
          (
            top: 660,
            child: Lottie.asset("assets/botoninicio.json",width : 220))
          )
         
            ,
          Positioned
          (
            top: 250,
            child: isLoading? Lottie.asset("assets/carga.json",width : 200): Container()
          
          ),
          ],            
            //contenedor multiple de elementos en el Container
          ),
        )

    );
  }
}

//gesture detector 
//