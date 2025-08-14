import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_assign/model/userModel.dart';
import 'package:my_assign/provider/loginProvider.dart';
import 'package:my_assign/utils/text_field_form.dart';
import 'package:my_assign/utils/userInformation.dart';
import 'package:my_assign/widget/custom_rounded_button.dart';
import 'package:provider/provider.dart';

import 'dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
    LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: Column(
             mainAxisAlignment:MainAxisAlignment.center,
              children: [
                TextFieldForm(
                    hintText: 'Email',
                    controller: emailController,
                ),
                SizedBox(height: 20.h,),
                TextFieldForm(
                  hintText: 'password',
                  controller: passwordController,
                ),

                SizedBox(height: 50.h,),
                CustomRoundedButton(
                    btnName: 'Login',
                    onPress: () async {
                      try {
                        await context.read<LoginProvider>().login(emailController.text.trim(), passwordController.text.trim());
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => DashboardScreen()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },

                    isLoading: context.watch<LoginProvider>().isLoading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
