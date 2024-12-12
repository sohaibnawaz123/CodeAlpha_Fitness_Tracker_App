import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/bloc/fitnessBloc.dart';
import 'package:fitnessapp/ui/homeScreen.dart';
import 'package:fitnessapp/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Fitnessbloc>(
      create: (context) => Fitnessbloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          title: 'Fitness App',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Apptheme.secondaryColor,
            useMaterial3: true,
          ),
          home: const HomeScreen()),
    );
  }
}
