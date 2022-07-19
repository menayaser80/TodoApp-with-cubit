import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoo/bloc_observer.dart';
import 'package:todoo/todo/cubit.dart';
import 'package:todoo/todo/states.dart';
import 'components.dart';
void main()
{
  BlocOverrides.runZoned(
        () {
          runApp(MaterialApp(home: HomeScreen()));
    },
    blocObserver: MyBlocObserver(),
  );

}
class HomeScreen extends StatelessWidget
{
  var scaffoldkey=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();
  var titlecontroller=TextEditingController();
  var timecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createdatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (BuildContext context,AppStates state)
          {
           if(state is AppInsertDataBase)
             {
               Navigator.pop(context);
             }
          },
          builder: (BuildContext context,AppStates state){
            AppCubit cubit=AppCubit.get(context);
            return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
    leading: const Icon(
    Icons.menu,
    ),
    title: Text(
    cubit.title[cubit.currentindex],
    ),
    actions: const [
    Icon(Icons.notification_important
    ),
    ],
    ),
    body: ConditionalBuilder(
    condition:state is!AppGetDataBaseLoading,
    builder:(context)=>cubit.screens[cubit.currentindex] ,
    fallback:(context)=>Center(child: CircularProgressIndicator()) ,
    ),
    floatingActionButton: FloatingActionButton(onPressed: () {
    if(cubit.isclosed)
    {
    if(formkey.currentState!.validate())
    {
      cubit.insertdatabase(title:titlecontroller.text , time:timecontroller.text, date:datecontroller.text,);
    }
    }
    else{
    scaffoldkey.currentState!.showBottomSheet((context) =>Container(
    color: Colors.grey[100],
    padding: EdgeInsets.all(20.0) ,
    child: Form(
    key: formkey,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    defaultformfield(controller: titlecontroller,
    type: TextInputType.text,
    validator: (value)
    {
    if(value!.isEmpty)
    {
    return 'title must not be empty';
    }
    return null;
    },
    label: 'Task Title',
    prefix:Icons.title,
    ),
    SizedBox(
    height: 15.0,
    ),
    defaultformfield(controller: timecontroller,
    type: TextInputType.datetime,
    validator: (value)
    {
    if(value!.isEmpty)
    {
    return 'time must not be empty';
    }
    return null;
    },
    ontap: (){
    showTimePicker(context:context ,
    initialTime:TimeOfDay.now(),
    ).then((value) {
    timecontroller.text=value!.format(context).toString();
    print(value!.format(context));
    });
    },
    label: 'Task time',
    prefix:Icons.watch_later_outlined,
    ),
    SizedBox(
    height: 15.0,
    ),
    defaultformfield(controller: datecontroller,
    type: TextInputType.datetime,
    validator: (value)
    {
    if(value!.isEmpty)
    {
    return 'date must not be empty';
    }
    return null;
    },
    ontap: (){
    showDatePicker(context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.parse('2025-11-26'),
    ).then((value) {
    datecontroller.text=DateFormat.yMMMd().format(value!);
    });
    },
    label: 'Task Date',
    prefix:Icons.calendar_today,
    ),
    ],
    ),
    ),
    ) ,
    ).closed.then((value)
    {
      cubit.Changebottomsheet(isshow: false, icon: Icons.edit);
    });
    cubit.Changebottomsheet(isshow: true, icon: Icons.add);
    }
    },child: Icon(
   cubit.fabicon,
    ),),
    bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
    BottomNavigationBarItem(icon: Icon(
    Icons.menu,
    ),
    label: 'tasks'
    ),
      BottomNavigationBarItem(icon: Icon(
    Icons.sanitizer_outlined,
    ),
    label: 'sales'
    ),
    BottomNavigationBarItem(icon: Icon(
    Icons.set_meal,
    ),
    label: 'meal'
    ),
    ],
    currentIndex:cubit.currentindex,
    onTap: (index)
    {
     cubit.changeindex(index);
      },
    selectedItemColor: Colors.red,
    backgroundColor: Colors.grey,
    ),
    );
    },
      ),
    );
  }
  Future<String>getname()async
  {
    return 'ahmed ali';
  }

}



