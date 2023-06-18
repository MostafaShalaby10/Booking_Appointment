import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors/bloc/states.dart';
import 'package:doctors/model/bookModel.dart';
import 'package:doctors/model/doctorModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cubit extends Cubit<States> {
  cubit() : super(InitialState());

  static cubit get(context) => BlocProvider.of(context);
  List<String> doctors = [
    "انف و اذن ",
    "جراحه",
    "الأسنان",
    "امراض عصبيه",
    "عظام",
    "اطفال"
  ];
String? id ;
  void login({
    required String email,
    required String password,
  }) {
    id = null;
    emit(LoadingLogin());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
         id = value.user!.uid ;
         getPatients();
      emit(SuccessfulLogin());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLogin(error: error.toString()));
    });
  }

  DoctorModel? userModel;

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialization,
    required String startTime,
    required String endTime,
    required String price,
  }) {
    emit(LoadingRegister());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          email: email,
          specialization: specialization,
          phone: phone,
          endTime: endTime,
          startTime: startTime,
          price: price,
          id: value.user!.uid);
      emit(SuccessfulRegister());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegister(error: error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String specialization,
    required String phone,
    required String id,
    required String startTime,
    required String endTime,
    required String price,
  }) {
    emit(LoadingInsertDoctor());
    userModel = DoctorModel(
        id: id,
        email: email,
        phone: phone,
        name: name,
        specialization: specialization,
        startTime: startTime,
        endTime: endTime,
        price: price);
    FirebaseFirestore.instance
        .collection("Doctors")
        .doc(id)
        .set(userModel!.tomap())
        .then((value) {
      emit(SuccessfulInsertDoctor());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorInsertDoctor(error: error.toString()));
    });
  }

  List<dynamic> allDoctors = [];

  void getspecialization(String s) async {
    allDoctors = [];
    emit(LoadingGetSpecialization());
    FirebaseFirestore.instance.collection("Doctors").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["specialization"] == s) {
          allDoctors.add(DoctorModel.fromjson(element.data()));
        }
      });

      emit(SuccessGetSpecialization());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetSpecialization());
    });
  }

  PatientModel? patientModel;

  void bookAnAppointment({
    required String age,
    required String name,
    required String phone,
    required String id,
  }) {
    patientModel = PatientModel(
      age: age,
      name: name,
      phone: phone,
    );
    emit(LoadingBooking());
    FirebaseFirestore.instance
        .collection("Doctors")
        .doc(id)
        .collection("Booking")
        .add(patientModel!.tomap())
        .then((value) {
      emit(SuccessBooking());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorBooking());
    });
  }
  List<dynamic> allPatients = [];

  void getPatients()
  {
    allPatients = [];
    emit(LoadingGetAllPatients());
    FirebaseFirestore.instance.collection("Doctors").doc(id).collection("Booking").get().then((value) {
      value.docs.forEach((element) {
          allPatients.add(PatientModel.fromjson(element.data()));

      });

      emit(SuccessGetAllPatients());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetAllPatients());
    });
  }
}
