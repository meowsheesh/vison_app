import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:textocr/bloc/blocs.dart';
import 'package:textocr/bloc/splash_screen/splash_screen_event.dart';
import 'package:textocr/bloc/splash_screen/splash_screen_state.dart';

import '../../services/history.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final HistoryService _historyService;

  SplashScreenBloc(this._historyService) : super(SplashScreenInitial()) {
    on<SplashScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SplashInitEvent>((event, emit) async {
      await _historyService.init();
      emit(ReadyState());
    });
    add(SplashInitEvent());
  }
}
