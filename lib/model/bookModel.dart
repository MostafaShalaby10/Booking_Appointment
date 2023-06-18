class PatientModel {
  String? name;

  String? phone;

  String? age;


  PatientModel({this.name, this.phone,  this.age});

  PatientModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    age = json['age'];
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "phone": phone,
      "age": age,
    };
  }
}
