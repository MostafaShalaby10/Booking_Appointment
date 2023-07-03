import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctors/pages/Doctors/home.dart';
import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/components/components.dart';
import 'package:doctors/pages/admin/admin.dart';
import 'package:doctors/pages/user/home.dart';
import 'package:doctors/sharedPrefs/sharedprefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isPass = true;

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(builder: (context, state) {
      return Scaffold(
        appBar: appBar(context, page: const UserHomePage() , icon: Icons.home , text: "Home"),
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
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
                      height: 5,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ConditionalBuilder(
                        condition: state is! LoadingLogin,
                        builder: (context) => button(context,
                                formKey: formKey, text: "Login", function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator())),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfulLogin) {
        Fluttertoast.showToast(
            msg: "Login successfully",
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        if (emailController.text == "admin@gmail.com" &&
            passwordController.text == "123456") {
          sharedprefs.savedata(key: "login", value: true) ;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Admin()),
              (route) => false);
        } else {
          sharedprefs.savedata(key: "login", value: true) ;

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DoctorHomePage()),
              (route) => false);
        }
      } else if (state is ErrorLogin) {
        Fluttertoast.showToast(
            msg: "Login failed ${state.error}",
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
  }
}
