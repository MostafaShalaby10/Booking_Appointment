import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/components/components.dart';
import 'package:doctors/pages/authentication/login.dart';
import 'package:doctors/pages/user/Specialization.dart';
import 'package:doctors/pages/user/doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> items = [
      PopupMenuItem(
        value: 0,
        child: Row(
          children: [
            Icon(
              Icons.login,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Doctor")
          ],
        ),
      ),
    ];
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          // cubit.get(context).getspecialization();
          return ConditionalBuilder(
              condition: true,
              builder: (context) => Scaffold(
                    backgroundColor: Colors.white,
                    appBar: appBar(context, page: const Login() , icon: Icons.login , text: "Doctor"),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    cubit.get(context).getspecialization(
                                        cubit.get(context).doctors[index]);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Doctors(),
                                        ));
                                  },
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
                                              image: AssetImage(
                                                  "assets/doctor.png"),
                                              width: 50),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Text(
                                              cubit.get(context).doctors[index],
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.navigate_next))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemCount: cubit.get(context).doctors.length,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }
}
