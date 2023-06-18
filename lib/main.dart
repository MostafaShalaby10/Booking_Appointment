import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/pages/user/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, States>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.white,

                  scaffoldBackgroundColor: Colors.white),
              debugShowCheckedModeBanner: false,
              home: const UserHomePage(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
