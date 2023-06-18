import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/pages/authentication/login.dart';
import 'package:doctors/pages/user/doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: true,
              builder: (context) => Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black ,
                                    width: 1
                                  )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name is :  ${cubit.get(context).allPatients[index].name}") ,
                                      SizedBox(height: 20,),
                                      Text("Age is :  ${cubit.get(context).allPatients[index].age}") ,
                                      SizedBox(height: 20,),
                                      Text("Phone is :  ${cubit.get(context).allPatients[index].phone}") ,
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                              const SizedBox(
                                height: 10,
                              ),
                              itemCount: cubit.get(context).allPatients.length,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});;
  }
}
