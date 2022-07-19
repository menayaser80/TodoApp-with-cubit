import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todoo/archized.dart';
import 'package:todoo/done.dart';
import 'package:todoo/new.dart';
import 'package:todoo/todo/states.dart';
class AppCubit extends Cubit <AppStates>
{
  AppCubit():super(AppInitialState());
  static AppCubit get (context)=>BlocProvider.of(context);
  int currentindex=0;
  List<Widget>screens=[
    New(),
    Done(),
    Archized(),
  ];
  List<String>title=[
    'new tasks',
    'done tasks',
    'archized tasks',
  ];
  void changeindex (int index)
  {
    currentindex=index;
    emit(AppChangeBottomState());
  }
  late Database database;
  List<Map>newtasks=[];
  List<Map>donetasks=[];
  List<Map>archizedtasks=[];
  Future<void>createdatabase()
  async {
    openDatabase(
        'mena.db',
        version: 1,
        onCreate: (database,version)async
        {
          print('database created');
          await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value){
            print ('tablecreated');
          } ).catchError((error){
            print('error${error.toString()}');
          }
          );
        },
        onOpen: (database)
        {
          getdatafromdatabase(database);
          print('database opened');
        },
        ).then((value){
          database=value;
          emit(AppCreateDataBase());
    });
  }
  insertdatabase(
      {
        required String title,
        required String time,
        required String date,
      }
      )
  async {
   await database.transaction((txn) async {
       txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","")')
          .then((value) {
        print(' inserted successfully');
        emit(AppInsertDataBase());
        getdatafromdatabase(database);
          }).catchError((error){
        print('error when inserting ${error.toString()}');
      });
      return null;
    });
  }
  void getdatafromdatabase(database)
  {
    newtasks=[];
    donetasks=[];
    archizedtasks=[];
    emit(AppGetDataBaseLoading());
    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {

        if(element['status']=='new')
          newtasks.add(element);
        else if(element['status']=='done')
          donetasks.add(element);
        else
          archizedtasks.add(element);

      });
      emit(AppGetDataBase());
    });
  }
  void UpdateData({
  required String status,
    required int id,
})async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id ],
    ).then((value) {
      getdatafromdatabase(database);
      emit(AppUpdateDataBase());
     });
  }
  void DeleteData({
    required int id,
  })async
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value) {
      getdatafromdatabase(database);
      emit(AppDeleteDataBase());
    });
  }
  bool isclosed=false;
  IconData fabicon=Icons.edit;
  void Changebottomsheet({
required bool isshow,
    required IconData icon,
})
  {
    isclosed=isshow;
    fabicon=icon;
    emit(Isclosedstate());

  }


}