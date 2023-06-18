import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/components/components.dart';
import 'package:doctors/pages/admin/addDoctor.dart';
import 'package:doctors/pages/user/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Doctors extends StatelessWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    var formKey = GlobalKey<FormState>();

    var nameOfDoctorController = TextEditingController();

    var nameController = TextEditingController();

    var ageController = TextEditingController();

    var phoneController = TextEditingController();
    return BlocConsumer<cubit, States>(builder: (context, state) {
      return ConditionalBuilder(
          condition: state is! LoadingGetSpecialization,
          builder: (context) => Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      children: [
                                        const Image(
                                            image:
                                                AssetImage("assets/doctor.png"),
                                            width: 50),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                cubit
                                                    .get(context)
                                                    .allDoctors[index]
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "from : ${cubit.get(context).allDoctors[index].startTime} : to ${cubit.get(context).allDoctors[index].endTime}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MaterialButton(
                                              minWidth: 6,
                                              color: Colors.green,
                                              onPressed: () {
                                                scaffoldKey.currentState
                                                    ?.showBottomSheet(
                                                        (context) {
                                                  nameOfDoctorController.text =
                                                      cubit
                                                          .get(context)
                                                          .allDoctors[index]
                                                          .name;
                                                  return Form(
                                                    key: formKey,
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.8,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 12,
                                                                  horizontal:
                                                                      5),
                                                          child: Column(
                                                            children: [
                                                              editText(
                                                                  controller:
                                                                      nameOfDoctorController,
                                                                  text:
                                                                      "NameOfDoctor",
                                                                  isPassword:
                                                                      false,
                                                                  prefixIcon: Icons
                                                                      .person_outline,
                                                                  type:
                                                                      TextInputType
                                                                          .name,
                                                                  enable:
                                                                      false),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              editText(
                                                                  controller:
                                                                      nameController,
                                                                  text: "Name",
                                                                  isPassword:
                                                                      false,
                                                                  prefixIcon: Icons
                                                                      .person_outline,
                                                                  type:
                                                                      TextInputType
                                                                          .name),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              editText(
                                                                  controller:
                                                                      ageController,
                                                                  text: "Age",
                                                                  isPassword:
                                                                      false,
                                                                  prefixIcon: Icons
                                                                      .numbers,
                                                                  type: TextInputType
                                                                      .number),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              editText(
                                                                  controller:
                                                                      phoneController,
                                                                  text: "Phone",
                                                                  isPassword:
                                                                      false,
                                                                  prefixIcon: Icons
                                                                      .phone_outlined,
                                                                  type: TextInputType
                                                                      .phone),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              ConditionalBuilder(
                                                                condition: state
                                                                    is! LoadingBooking,
                                                                builder: (context) => button(
                                                                    context,
                                                                    formKey:
                                                                        formKey,
                                                                    text:
                                                                        "Book",
                                                                    function:
                                                                        () {
                                                                  if (formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    cubit.get(context).bookAnAppointment(
                                                                        phone: phoneController
                                                                            .text,
                                                                        name: nameController
                                                                            .text,
                                                                        age: ageController
                                                                            .text,
                                                                        id: cubit
                                                                            .get(context)
                                                                            .allDoctors[index]
                                                                            .id);
                                                                  }
                                                                }),
                                                                fallback: (context) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Text(
                                                "Book",
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Price : ${cubit.get(context).allDoctors[index].price}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: cubit.get(context).allDoctors.length,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()));
    }, listener: (context, state) {
      if (state is SuccessBooking) {
        Fluttertoast.showToast(
            msg: "Book successfully",
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
            (route) => false);
      } else if (state is ErrorBooking) {
        Fluttertoast.showToast(
            msg: "Book failed",
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
  }
}
