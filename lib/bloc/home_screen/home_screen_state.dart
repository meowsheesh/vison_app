import 'package:equatable/equatable.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class InitState extends HomeScreenState {}

class ImageChoosenState extends HomeScreenState {
  final String text;

  ImageChoosenState({required this.text});
}
