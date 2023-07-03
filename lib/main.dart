import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/pages/Doctors/home.dart';
import 'package:doctors/pages/authentication/login.dart';
import 'package:doctors/pages/user/home.dart';
import 'package:doctors/sharedPrefs/sharedprefrences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedprefs.init();
  bool? isLogin = sharedprefs.getdata(key: "login");
if(isLogin==null)
  {
    runApp(const MyApp(
      start: UserHomePage(),
    ));
  }else
    {
      runApp(const MyApp(
        start: DoctorHomePage(),
      ));
    }
}

class MyApp extends StatelessWidget {
    final Widget start ;
  const MyApp({super.key, required this.start});
  @override
  Widget build(BuildContext context) {
    if(start is DoctorHomePage) {
      return BlocProvider(
      create: (BuildContext context) => cubit() ..getPatients(),
      child: BlocConsumer<cubit, States>(
          builder: (context, state) {

            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.white,

                  scaffoldBackgroundColor: Colors.white),
              debugShowCheckedModeBanner: false,
              home:start ,
            );
          },
          listener: (context, state) {}),
    );
    }
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, States>(
          builder: (context, state) {

            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.white,

                  scaffoldBackgroundColor: Colors.white),
              debugShowCheckedModeBanner: false,
              home:start ,
            );
          },
          listener: (context, state) {}),
    );
  }
}
