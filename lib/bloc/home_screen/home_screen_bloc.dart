import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textocr/bloc/home_screen/home_screen.dart';
import 'package:textocr/services/history.dart';

final ImagePicker picker = ImagePicker();
final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final HistoryService _historyService;

  HomeScreenBloc(this._historyService) : super(HomeScreenInitial()) {
    on<InitEvent>(_init);
    on<OnChooseImageTapped>(_chooseImageTapped);
    on<OnTakeImageTapped>(_takePhotoImage);

    add(InitEvent());
  }

  Future<void> _init(
      HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    emit(InitState());
  }

  Future<void> _chooseImageTapped(
      OnChooseImageTapped event, Emitter<HomeScreenState> emit) async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    var selectedImage = File(image!.path);
    final inputImage = InputImage.fromFile(selectedImage);
    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = await recognizedText.text;
    try{
      _historyService.addTask(text, image.path.toString());
    }catch(e,s){
      print(s);
      print(e);
    }
    emit(ImageChoosenState(text: text));
    emit(InitState());
  }

  Future<void> _takePhotoImage(
      HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    var selectedImage = File(photo!.path);
    final inputImage = InputImage.fromFile(selectedImage);
    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = await recognizedText.text;
    try{
      _historyService.addTask(text, photo.path.toString());
    }catch(e,s){
      print(s);
      print(e);
    }

    emit(ImageChoosenState(text: text));
    emit(InitState());
  }
}
