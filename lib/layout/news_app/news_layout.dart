
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/shared/components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../modules/news_app/search/search_screen.dart';


class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context, state) {


        var cubit=NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(onPressed:(){
                navigateTo(context, searchScreen());
              } , icon: const Icon(Icons.search),),
              IconButton(onPressed: ()  {

                cubit.changeAppTheme();

              },icon: const Icon(Icons.brightness_6_outlined))

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              elevation: 20.0,
              currentIndex: cubit.currentIndex,
              items:cubit.bottomItems,
              onTap: (index)
              {
                cubit.changeBottomNavBar(index);
              },
          ),


        );
      },
      listener:(context, state) {
        print(state.toString());
        print(Theme.of(context).textTheme.bodyMedium?.color.toString());

      },

    );
  }
}
