import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState {

}

class ReadyState extends SplashScreenState {}
