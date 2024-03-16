import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/social layout.dart';
import '../../shared/reusable.dart';
import '../register/register_screen.dart';
import 'login_cubit.dart';
import 'login_states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class login extends StatelessWidget {
  var email=TextEditingController();
  var password=TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is FailLogin)
            {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: "Error",
                desc: state.x
              ).show();

            }
          else if(state is SuccessLogin )
            {
              if(FirebaseAuth.instance.currentUser!.emailVerified ) {
                Navigator.push(context, MaterialPageRoute(builder: (_){return const SocialLayout(); }));
              }
              else
                {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: "Error",
                      desc: "go and verify your email",
                  ).show();

                }
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
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'login now to connect with your friends',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReusableTextForm(
                        hintText: 'enter your email',
                        labelText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        TextController: email,
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
                        TextController: password,
                        onFieldSubmitted: (value) {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "enter your password";
                          }
                          return null;
                        },
                        suffixIcon: !LoginCubit.get(context).isScure
                            ? const Icon(
                                Icons.visibility_off,
                              )
                            : const Icon(
                                Icons.visibility,
                              ),
                        onPressed: () {
                          LoginCubit.get(context).ChangeisScure();
                        },
                        obscureText: !LoginCubit.get(context).isScure,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReusableButtom(text: 'LOGIN', onPressed: () {
                        if(formKey.currentState!.validate())
                          {
                            LoginCubit.get(context).UserData(
                                email: email.text,
                                password: password.text, );
                          }
                      }),

                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ? ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),

                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (h){
                              return RegisterScreen();}
                            ));
                          }, child: const Text("REGISTER"))
                        ],
                      )
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
