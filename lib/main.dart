import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textocr/bloc/blocs.dart';
import 'package:textocr/bloc/home_screen/home_screen_bloc.dart';
import 'package:textocr/screens/auth_screen.dart';
import 'package:textocr/screens/history_screen.dart';
import 'package:textocr/screens/info_screen.dart';
import 'package:textocr/screens/splash_screen.dart';
import 'package:textocr/services/history.dart';

import 'screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HistoryService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => BlocProvider(
              create: (context) => SplashScreenBloc(
                RepositoryProvider.of<HistoryService>(context)
              ),
            child: SplashScreen(),
          ),
          '/home': (context) => BlocProvider<HomeScreenBloc>(
                create: (context) => HomeScreenBloc(
                    RepositoryProvider.of<HistoryService>(context)
                ),
                child: HomeScreen(),
              ),
          '/infoscreen': (context) => InfoScreen(),
          '/historyScreen': (context) => HistoryScreen(
            historyService: RepositoryProvider.of<HistoryService>(context),
          ),
          '/auth': (context) => AuthScreen(),
        },
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff101010),
            secondary: const Color(0xff101010),
          ),
          scaffoldBackgroundColor: const Color(0xff1C1E1F),
          textTheme: const TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            headline4: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
