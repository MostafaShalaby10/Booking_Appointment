class DoctorModel {
  String? name;

  String? email;

  String? phone;

  String? id;

  String? specialization;
  String? startTime;
  String? endTime;
  String? price;

  DoctorModel(
      {this.name, this.email, this.phone, this.id, this.specialization , this.price , this.endTime , this.startTime});

  DoctorModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    specialization = json['specialization'];
    price = json['price'];
    endTime = json['endTime'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
      "specialization": specialization,
      "price": price,
      "endTime": endTime,
      "startTime": startTime,
    };
  }
}
