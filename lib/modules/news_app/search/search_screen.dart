
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../shared/components/components.dart';


class searchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultTextFeild(
                  color: Colors.deepOrange,
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onSubmit: (String value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: list.isNotEmpty,
                  builder: (context) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildArticalItem(list[index], context),
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                      itemCount: 15,
                    );
                  },
                   fallback: (context) => state is NewsGetSearchLoadingState? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                   ):Container(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
