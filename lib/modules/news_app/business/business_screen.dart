
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, NewsStates state)
      {

      },
      builder: (BuildContext context, NewsStates state) {
        var list=NewsCubit.get(context).business;
        return ConditionalBuilder(
          condition:list.length>0,
          builder: (context){

             return ListView.separated(
               physics: const BouncingScrollPhysics(),
                 itemBuilder: (context,index)=>buildArticalItem(list[index],context),
                 separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,color: Colors.grey,),
                 itemCount: 15,
             );

          },
          fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),
        );
      },

    );
  }
}
