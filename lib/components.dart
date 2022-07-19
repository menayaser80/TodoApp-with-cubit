import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'todo/cubit.dart';

Widget defaultbutton(
    {
      double width=double.infinity,
      Color background=Colors.blue,
      required VoidCallback function,
      bool isuppercase=true,
      required String text,
      double radius=0.0,
    })=>Container(
  width: width,
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(radius),
  ),
  child: MaterialButton(onPressed:function,
    child: Text(
      isuppercase? text.toUpperCase():text,
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
  VoidCallback? ontap,
  bool isclickable=true,
})=> TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefix,
      ),
      labelText: label,
      border: OutlineInputBorder(),
    ),
    validator: validator,
    onTap: ontap,
    keyboardType:type,
    onChanged:onchange,
  enabled: isclickable,

);
Widget defaultpassword({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispassword=false,
  VoidCallback? suffixpressed,
})=>TextFormField(
  controller: controller,
  decoration: InputDecoration(
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null?IconButton(
      onPressed:suffixpressed,
      icon:   Icon(
        suffix,
      ),
    ):null,
    labelText: label,
    border: OutlineInputBorder(),
  ),
  validator: validator,
  keyboardType:type,
  obscureText: ispassword,
  onChanged: onchange,
);
Widget builditem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
              '${model['time']}'
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text('${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
                ),),
  
              Text('${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),),
  
  
  
            ],
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        IconButton(onPressed: (){
  
          AppCubit.get(context).UpdateData(status: 'done', id: model['id'],);
  
          },
  
          icon: Icon(
  
        Icons.check_box,
  
            color: Colors.green,
  
        ),
  
        ),
  
        IconButton(onPressed: (){
  
          AppCubit.get(context).UpdateData(status: 'archive', id: model['id'],);
  
          },
  
          icon: Icon(
  
            Icons.archive,
  
            color: Colors.blueGrey ,
  
          ),
  
        ),
  
        
  
      ],
  
    ),
  
  ),
  onDismissed:(direction)
  {
AppCubit.get(context).DeleteData(id: model['id']);
  } ,
);
Widget TasksBuilder({
  required List<Map>tasks,
})=>ConditionalBuilder(
condition: tasks.length>0,
builder:(context)=> ListView.separated(itemBuilder:(context,index)=>builditem(

tasks[index],context), separatorBuilder: (context,index)=>Padding(

padding: EdgeInsetsDirectional.only(

start: 20.0,

),

child: Container(

width: double.infinity,

height: 1.0,

color: Colors.grey[300],

),

), itemCount: tasks.length),
fallback:(context)=>Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.menu,
size: 100.0,
color: Colors.grey,
),
Text(
'No Tasks yet,please add some tasks',
style: TextStyle(
fontSize: 16.0,
fontWeight: FontWeight.bold,
color: Colors.grey,
),
),
],
),
) ,
);