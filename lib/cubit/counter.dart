import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/cubit/cubit.dart';
import 'package:todoo/cubit/states.dart';
class counter extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>CounterCubit(),
      child: BlocConsumer< CounterCubit,CounterStates>(
      listener: (BuildContext context,CounterStates state){
        if(state is CounterInitialState)
          {//print('InitialState');
             }
        if(state is CounterPlusState)
          {//print('PlusState${state.count}');
             }
        if(state is CounterMinusState)
          {//print('MinusState${state.count}');
             }
      },
        builder: (BuildContext context,CounterStates state){
        return Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Counter',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          ),
          ),
          actions: [
          Icon(Icons.menu),
          ],
          ),
          body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton(onPressed: (){
         CounterCubit.get(context).minus();

          }, child: Text(
          'MinUS',
          style: TextStyle(
          fontSize: 20.0,
          color: Colors.red,
          ),
          ),),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,),
          child: Text('${CounterCubit.get(context).count}',
          style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.w900,
          ),),
          ),
          TextButton(onPressed: (){
            CounterCubit.get(context).plus();
            }, child: Text(
          'Plus',
          style: TextStyle(
          fontSize: 20.0,
          color: Colors.green,
          ),
          ),),
          ],
          ),
          ),
          ),
          );
        },
      ),
    );
  }
}
