import 'package:doctors/bloc/bloc.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/components/components.dart';
import 'package:doctors/pages/admin/addDoctor.dart';
import 'package:doctors/pages/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit , States>(builder: (context , state){
      return Scaffold(
        appBar: appBar(context, page: const Login() , icon: Icons.logout , text: "Logout"),

        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDoctor()));
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.all(40),
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(30) ,
                        color: Colors.green
                      ),
                      child: Text(
                        "Add doctors" ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black ,
                          fontWeight: FontWeight.bold ,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    }, listener: (context , state){});
  }
}
