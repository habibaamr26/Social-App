import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social%20screen/register/register_cubit.dart';
import 'package:social_app/social%20screen/register/register_states.dart';
import '../../layout/social layout.dart';
import '../../shared/reusable.dart';
import '../login/login screen.dart';


class RegisterScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => registerCubit(),
      child: BlocConsumer<registerCubit, registerStates>(
        listener: (context, state) {
          if(state is SuccessData)
            {
              Navigator.push(context, MaterialPageRoute(builder: (F){
                return login();
              }));
            }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Register now to communicate with your friends',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReusableTextForm(
                        hintText: 'enter your name',
                        labelText: 'User Name',
                        keyboardType: TextInputType.name,
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        TextController: namecontroller,
                        onFieldSubmitted: (value) {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "enter your name please";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 17,
                      ),


                      ReusableTextForm(
                        hintText: 'enter your email address',
                        labelText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        TextController: emailcontroller,
                        onFieldSubmitted: (value) {if(formKey.currentState!.validate())
                        {

                        }},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "enter your email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      ReusableTextForm(
                        hintText: 'enter your password',
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        TextController: passwordcontroller,
                        onFieldSubmitted: (value) {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "enter your password";
                          }
                          return null;
                        },
                        suffixIcon: !registerCubit.get(context).isScure
                            ? Icon(
                          Icons.visibility_off,
                        )
                            : Icon(
                          Icons.visibility,
                        ),
                        onPressed: () {
                          registerCubit.get(context).ChangeisScure();
                        },
                        obscureText: !registerCubit.get(context).isScure,
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      ReusableTextForm(
                        hintText: 'enter your phone number',
                        labelText: 'Phone',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                        TextController: phonecontroller,
                        onFieldSubmitted: (value) {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "enter your phone number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      ReusableButtom(text: 'Register', onPressed: () {
                        if(formKey.currentState!.validate())
                        {
                          registerCubit.get(context).UserData(email: emailcontroller.text,
                              name: namecontroller.text,
                              phone: phonecontroller.text,
                              password: passwordcontroller!.text,

                          );
                          FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.scale,
                                title: "Error",
                                desc: "an email send to mail to be varificade"
                            ).show();
                          });
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
