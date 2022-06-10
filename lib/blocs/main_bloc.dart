import 'package:rxdart/subjects.dart';

class MainBloc {
  Stream<int> get pageIndex => _pageIndexController.stream;
  final _pageIndexController = BehaviorSubject<int>();

  void setPageIndex(int pageIndex) {
    _pageIndexController.add(pageIndex);
  }

  void dispose() {
    _pageIndexController.close();
  }
}
