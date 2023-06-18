import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/components/components.dart';
import 'package:doctors/pages/admin/admin.dart';
import 'package:doctors/pages/user/doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  bool isPass = true;
  bool isConfPass = true;
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confPasswordController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var priceController = TextEditingController();
  String? specializationController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(builder: (context, state) {
      var items = ['1', '2', '3'];
      return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Insert Doctor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      editText(
                          controller: nameController,
                          text: "Name",
                          prefixIcon: Icons.person_outline,
                          type: TextInputType.name,
                          isPassword: false),
                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: emailController,
                          text: "E-mail",
                          prefixIcon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          isPassword: false),
                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: passwordController,
                          text: "Password",
                          prefixIcon: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          isPassword: isPass,
                          suffixIcon:
                              isPass ? Icons.visibility : Icons.visibility_off,
                          function: () {
                            setState(() {
                              isPass = !isPass;
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: confPasswordController,
                          text: "Conf-Password",
                          prefixIcon: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          isPassword: isConfPass,
                          suffixIcon: isConfPass
                              ? Icons.visibility
                              : Icons.visibility_off,
                          function: () {
                            setState(() {
                              isConfPass = !isConfPass;
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: phoneController,
                          text: "Phone",
                          prefixIcon: Icons.phone_outlined,
                          type: TextInputType.phone,
                          isPassword: false),

                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: startTimeController,
                          text: "Start-time",
                          prefixIcon: Icons.timer,
                          type: TextInputType.datetime,
                          isPassword: false),

                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: endTimeController,
                          text: "End-time",
                          prefixIcon: Icons.timer,
                          type: TextInputType.datetime,
                          isPassword: false),

                      const SizedBox(
                        height: 10,
                      ),
                      editText(
                          controller: priceController,
                          text: "Price",
                          prefixIcon: Icons.attach_money,
                          type: TextInputType.number,
                          isPassword: false),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                              label: Text("Specialization"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          value: specializationController,
                          validator: (value) {
                            if (value == null) {
                              return "specialization can't be empty";
                            }
                            return null;
                          },
                          items: cubit.get(context).doctors.map((String i) {
                            return DropdownMenuItem(
                              value: i,
                              child: Text(i),
                            );
                          }).toList(),
                          onChanged: (value) {
                            specializationController = value!;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: state is! LoadingInsertDoctor,
                          builder: (context) => button(context,
                                  formKey: formKey, text: "Insert", function: () {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text ==
                                      confPasswordController.text) {
                                    cubit.get(context).register(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                        price: priceController.text,
                                        startTime: startTimeController.text,
                                        endTime: endTimeController.text,
                                        specialization:
                                            specializationController.toString());
                                  }
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator ())),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfulInsertDoctor) {
        Fluttertoast.showToast(
            msg: "Insert successfully",
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Admin()),
            (route) => false);
      } else if ( state is ErrorRegister) {
        Fluttertoast.showToast(
            msg: "Insert failed ${state.error}",
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
      else if ( state is ErrorInsertDoctor) {
        Fluttertoast.showToast(
            msg: "Insert failed ${state.error}",
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
  }
}
