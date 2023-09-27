import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MainPageCubit extends Cubit<int> {
  late List<Widget Function()> _pagesToCompose;
  Widget get currentPage => _pagesToCompose[state]();
  // Map<int, Widget> loadedPages = {};
  // Widget get currentPage {
  //   if (!loadedPages.containsKey(state))
  //     loadedPages[state] = _pagesToCompose[state]();
  //   return loadedPages[state];
  // }

  MainPageCubit({required pagesToCompose}) : super(0) {
    this._pagesToCompose = pagesToCompose;
  }

  void currentIndex(int index) => emit(index);
}
