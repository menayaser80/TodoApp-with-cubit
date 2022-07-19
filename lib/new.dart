import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/components.dart';
import 'package:todoo/constants.dart';
import 'package:todoo/todo/cubit.dart';
import 'package:todoo/todo/states.dart';

class New extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state)
      {

      },
      builder:(context,state)
      {
        var tasks=AppCubit.get(context).newtasks;
        return TasksBuilder(
          tasks: tasks,
        );
      },

    );
  }
}
