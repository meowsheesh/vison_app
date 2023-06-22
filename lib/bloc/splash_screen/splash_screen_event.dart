import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
}

class SplashInitEvent extends SplashScreenEvent {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
