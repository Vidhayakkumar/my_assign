
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_assign/model/userModel.dart';


import '../model/product_List_model.dart';

class AuthService{

  static const String loginUrl ='https://textradedata.lynxsoftech.com/api/authenticate/login';
  static const String listUrl = 'https://textradedata.lynxsoftech.com/api/order/get';

  Future<UserModel> login(String userName, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "username": userName,
          "password": password,
        }),
      );

      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonData);
      } else {
        final errorMsg = jsonData['message'] ?? 'Something went wrong';
        throw Exception(errorMsg);
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }


  Future<List<ProductListModel>> fetchUserData(String token) async {
    final url = Uri.parse(listUrl); // endpoint change as per API
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({"company_id": null,  "id": null,  "ledger_id": null,  "order_no": null,
        "from_date": "2024-05-05",  "to_date": "2024-05-21",  "status": null} )
    );

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductListModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch data");
    }
  }





}