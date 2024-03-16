import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import '../app_cubit/social_cubit.dart';
import '../app_cubit/social_status.dart';
import 'edit profile/edit profile_screen.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>
      (builder: (context,state){
        var cubit=SocialCubit.get(context).model;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                Container(
                  height: 210,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "${cubit?.cover}",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      CircleAvatar(
                        radius: 74,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "${cubit?.image}",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${cubit?.name}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "${cubit?.bio}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "posts",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "264",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "photos",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "10k",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "followers",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "64",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "following",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: ()  {

                            }, child: Text("Add Photo"))),
                    SizedBox(width: 8,),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (_){return EditScreen();})
                          );
                        }, child: Icon(IconBroken.Edit,size: 17,)),
                  ],
                )
              ],
            ),
          ),
        );
    }, listener: (context,state){});
  }
}
