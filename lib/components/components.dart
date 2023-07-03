import 'package:doctors/pages/authentication/login.dart';
import 'package:doctors/sharedPrefs/sharedprefrences.dart';
import 'package:flutter/material.dart';

Widget editText({
  required var controller,
  required String text,
  required bool isPassword,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function()? function,
  required TextInputType type,
   bool enable = true,
}) =>
    TextFormField(
      enabled: enable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "$text can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
          label: Text(text),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(onPressed: function, icon: Icon(suffixIcon)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black))),
    );

////////////////////////////////////////////////////////////////////////////////

Widget button(
  context, {
  required var formKey,
  required String text,
  required Function()? function,
}) =>
    Center(
      child: MaterialButton(

        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.black,
        minWidth: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
        onPressed: function ,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
PreferredSizeWidget? appBar(context , {required Widget page , required IconData icon , required String text})
{
  List<PopupMenuEntry> items = [
    PopupMenuItem(
      value: 0,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(text)
        ],
      ),
    ),
  ];

  return AppBar(
    title: Text("Booking" , style: TextStyle(color: Colors.black),),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    actions: [
      PopupMenuButton(
        itemBuilder: (context) => items,
        color: Colors.white,
        icon: Icon(Icons.menu , color: Colors.black,),
        onSelected: (value) {
          if (value == 0) {
            if(text=="Logout")
              sharedprefs.removedata(key: "login");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => page));
          }
        },
      ),
    ],
  );
}