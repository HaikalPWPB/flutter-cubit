import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  int index = 0;

  void selectIndex(value) => emit(index = value);
}
