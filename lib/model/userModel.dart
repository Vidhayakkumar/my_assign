class UserModel {
  String? username;
  String? email;

  UserModel(
      {
        this.username,
        this.email,
       });

  UserModel.fromJson(Map<String, dynamic> json) {

    username = json['name'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.username;
        data['email'] = this.email;

    return data;
  }
}