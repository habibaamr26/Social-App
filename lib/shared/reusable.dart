import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ReusableTextForm({
  required TextEditingController? TextController,
  void Function(String)? onFieldSubmitted,
  String? Function(String?)? validator,
   String? hintText,
  required String labelText,
  required TextInputType keyboardType,
  Icon? prefixIcon,
  Icon? suffixIcon,
  void Function()? onPressed,
  bool obscureText = false,
}) =>
    TextFormField(
        controller: TextController,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon != null ? prefixIcon : null,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onPressed, icon: suffixIcon)
              : null,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ));










Widget ReusableButtom({
  double height=50,
 required String text,
  required void Function()? onPressed,
})=> Container(
width: double.infinity,
height: height,
child: ElevatedButton(
onPressed: onPressed,
child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
));