
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4all/cubit/states.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../shared/end_points.dart';
import '../shared/network/local/cache_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDarkTheme =CacheHelper.getDate('isDark')??false;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),

  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    } else if (index == 1)
      getSports();
    else if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData('v2/top-headlines','',{
        'country': 'eg',
        'category': 'business',
        'apiKey': APIKEY,
      }).then((value) {
        print(value.data['totalResults']);

        business = value.data['articles'];

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData('v2/top-headlines','', {
        'country': 'eg',
        'category': 'sports',
        'apiKey': APIKEY,
      }).then((value) {
        print(value.data['totalResults']);

        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData('v2/top-headlines','', {
        'country': 'eg',
        'category': 'science',
        'apiKey': APIKEY,
      }).then((value) {
        print(value.data['totalResults']);

        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

      DioHelper.getData('v2/everything','', {
        'q': '$value',
        'apiKey': APIKEY,
      }).then((value) {

        search = value.data['articles'];

        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }

  void changeAppTheme() {
    isDarkTheme=!isDarkTheme;
    CacheHelper.putData(key: 'isDark', value: isDarkTheme);

    print (isDarkTheme);

    emit(AppChangeThemeState());
  }
}
