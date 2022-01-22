import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RootPageNotifier extends ChangeNotifier {
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void updatePageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  final pageViewController = PageController(
    keepPage: true,
    initialPage: 0,
  );

  void animateToIndex(int pageIndex) {
    pageViewController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}
