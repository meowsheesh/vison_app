import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends HomeScreenEvent {}

class OnChooseImageTapped extends HomeScreenEvent {}

class OnTakeImageTapped extends HomeScreenEvent {}
