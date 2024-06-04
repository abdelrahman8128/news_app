
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/shared/components/components.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var list=NewsCubit.get(context).science;

        return  ConditionalBuilder(
          condition:list.isNotEmpty ,
          builder:(context) => ListView.separated(

            itemBuilder: (context, index) => buildArticalItem(list[index],context),
            separatorBuilder: (context, index) => Container(color: Colors.grey,height: 1,),
            itemCount: 15,
          ),
          fallback: (context) =>  const Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),

        );
      },

    );

  }
}
