

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../app_cubit/social_cubit.dart';
import '../app_cubit/social_status.dart';
import '../social layout screen/post_screen.dart';
class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state) {
        var Cubit = SocialCubit.get(context);
       return  Scaffold(
            appBar: AppBar(
              title:Cubit.appBarTitel[Cubit.bottomNavigationCurrent],
              actions: [
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
              ],
            ),
            body: Cubit.Screens[Cubit.bottomNavigationCurrent],
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex:Cubit.bottomNavigationCurrent,
        onTap: (index)
        {
          Cubit.bottomNavigationCurrentChange(index);
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: "Chats"),
          BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: "Posts"),
        BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: "Users"),
        BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: "Settings"),
        ],
        ),
        );

      },
      listener: (BuildContext context, Object? state) {
        if (state is AddPostSate)
          {
            Navigator.push(context, MaterialPageRoute(builder:(_){
              return PostScreen();
            }
            ));
          }
      }
    );
  }
}











//if you dont make a verifstion
/* ConditionalBuilder(
        condition: !FirebaseAuth.instance.currentUser!.emailVerified,
        builder: (BuildContext context) =>Column(
          children: [
            Container(
              color: Colors.amberAccent.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 10,),
                    Text("Please verified your email",style: TextStyle(fontSize: 16),),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    }, child: Text("Send")),
                  ],
                ),
              ),
            )
          ],
        ),
        fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),)*/