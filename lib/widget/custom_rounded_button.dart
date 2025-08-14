import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRoundedButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPress;
  final bool isLoading ;
  const CustomRoundedButton({
    super.key,
    required this.btnName,
    required this.onPress,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.maxFinite,
        height: 45.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.green
        ),
        child: Center(
            child: isLoading?CircularProgressIndicator(
              color: Colors.white,
            )
                : Text(btnName,style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp
        ),)),
      ),
    );
  }
}
