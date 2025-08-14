

import 'package:flutter/cupertino.dart';
import 'package:my_assign/model/userModel.dart';
import 'package:my_assign/services/aurhService.dart';



class LoginProvider with ChangeNotifier{
  bool _isLoading = false;

  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  final AuthService _authService = AuthService();

  Future<void> login(String userName, String password)async{
    _isLoading = true;
    notifyListeners();

    try{
      _userModel = await _authService.login(userName, password);
      _isLoading = false;
      notifyListeners();

    }catch (e){
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }

  }


}