class UserModel {
  String? username;
  String? email;
  String? token;

  UserModel(
      {
        this.username,
        this.email,
         this.token,
       });

  UserModel.fromJson(Map<String, dynamic> json) {

    username = json['name'];
    email = json['email'];
    token = json['token'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.username;
        data['email'] = this.email;
        data['token'] = this.token;

    return data;
  }
}