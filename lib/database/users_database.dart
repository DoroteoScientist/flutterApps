//patron de diseno singleton
import 'dart:io';

import 'package:flutter_application_1/Models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
 import 'package:path_provider/path_provider.dart';
 //guion bajo indica variable privada
class UsersDatabase {
  static const NAMEDB = "USERDB";  
  static const versiondb = 1;
  static Database? _database;//apunta a la nase de datos local
  
  Future<Database?> get database  async// patron singleton
  {
      if(_database != null)
      return _database; 
      return _database = await initDatabse();
  }
  
  Future<Database?> initDatabse() async
  {
    Directory folder = await getApplicationDocumentsDirectory();
    String path =  join(folder.path,NAMEDB);
    return openDatabase(
      path,
      version : versiondb,
      onCreate: (db,version) {
        String query = '''CREATE TABLE tableUsers
        (idUser INTEGER PRIMARY KEY,
        userName VARCHAR(50),
        password VARCHAR(32));
        ''';
        db.execute(query);//se ejecuta el query creado en el on create
      }
    );
  }

  //la recuperacion de rutas es de fomra asicnrona
  Future<int> INSERT(Map<String,dynamic> data) async {//id del registro que inserto
    final Database? con = await database;// hace el llamado al get o al set
    return con!.insert('tableUsers', data);
  }

    Future<int> UPDATE(Map<String,dynamic> data)async {
    final  con = await database;
    return con!.update('tableUsers', data, 
     where: 'idUser=?', 
      whereArgs: [data['idUser']]);
  }
//consultas parametrizadsas

  Future<int> DELETE (int idUser) async {
    final con = await database;
    return con!.delete('tableUsers', where : 'idUser=?', whereArgs: [idUser]);
  }
  
  Future<List<UserModel>> SELECT() async {
    final con = await database;
    final res = await con!.query('tableUsers');
    return res.map((user) => UserModel.fromMap(user)).toList();
  }
  
}