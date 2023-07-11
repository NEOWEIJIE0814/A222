class User {
  String? id;
  String? email;
  String? name;
  String? password;
  String? otp;
  String? datereg;
  String? phone;
  String? token;

  User(
      {this.id,
      this.email,
      this.name,
      this.password,
      this.otp,
      this.datereg,
      this.phone,
      this.token,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    otp = json['otp'];
    datereg = json['datereg'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['otp'] = otp;
    data['datereg'] = datereg;
    data['phone']= phone;
    data['token'] = token;
    return data;
  }
}