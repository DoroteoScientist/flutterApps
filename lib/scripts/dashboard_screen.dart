import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global_values.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

class DashboardScreen  extends StatelessWidget {
   
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Drawer(),menu de hamburguesa
      drawer : SidebarX(
        headerBuilder: (context, extended)
        {
          return const UserAccountsDrawerHeader
          (currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('https://png.pngtree.com/png-clipart/20190516/original/pngtree-users-vector-icon-png-image_3725294.jpg'),
          ),
            accountName: Text('El usuario '), 
          accountEmail: Text('elusuario@gmail.com'));
        },
        extendedTheme: const SidebarXTheme( width: 200),
        controller: SidebarXController(selectedIndex: 0,extended: true),
        items : [SidebarXItem (
          onTap: () {Navigator.pop(context);
            Navigator.pushNamed(context, '/reto');
          },
          //(){  Navigator.push(context, route)},
          icon: Icons.home, label : 'Practica 1'),
          SidebarXItem (
          onTap: () {Navigator.pop(context);
            Navigator.pushNamed(context, '/api');
          },
          //(){  Navigator.push(context, route)},
          icon: Icons.home, label : 'Popular Movies')
          ]
        ),
        
      //endfrawer lo colca en el lado derecho, el pirmeor lo pone en el lado izquierdo
      appBar: AppBar(
        title: Text('Panel de control'),

      ),
      body : HawkFabMenu(
         icon: AnimatedIcons.menu_arrow,
         body: const Center(
          child: Text('Center of the screen'),
        ),
        items: [
          HawkFabMenuItem(
            label: 'Theme: Light',
            ontap: () => GlobalValues.themeMode.value = 1,
            icon: const Icon(Icons.light_mode),)
            ,HawkFabMenuItem(
            label: 'Theme: Dark',
            ontap: () => GlobalValues.themeMode.value = 0,
            icon: const Icon(Icons.dark_mode),)
            ,HawkFabMenuItem(
            label: 'Theme: Warm',
            ontap: () => GlobalValues.themeMode.value = 1,
            icon: const Icon(Icons.read_more),)
            ]          
      ), 
         //body: Center(child: Text('your content here'),),
    );
  }
}