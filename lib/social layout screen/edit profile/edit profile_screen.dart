import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../app_cubit/social_cubit.dart';
import '../../app_cubit/social_status.dart';
import '../../shared/reusable.dart';

import 'package:firebase_storage/firebase_storage.dart';

class EditScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context).model;
        var cubitImage = SocialCubit.get(context).coverImage;

        var cubitProfileImage = SocialCubit.get(context).profileImage;
        nameController.text = cubit!.name!;

        bioController.text = cubit.bio;

        phoneController.text = cubit!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
            titleSpacing: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: TextButton(
                    onPressed: () {
                      SocialCubit.get(context).UbdateFireBase(
                        phone: phoneController.text,
                        name: nameController.text,
                        bio: bioController.text,
                      );
                      if(state is GetUserDataSuccess)
                        Navigator.pop(context);
                    },
                    child: Text("UPDATE")),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 210,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    image: DecorationImage(
                                        image: cubitImage == null
                                            ? NetworkImage(
                                                "${cubit?.cover}",
                                              )
                                            : FileImage(File(cubitImage.path))
                                                as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getCoverImage();
                                        },
                                        icon: Icon(IconBroken.Camera))),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 74,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: cubitProfileImage == null
                                    ? NetworkImage(
                                        "${cubit?.image}",
                                      )
                                    : FileImage(File(cubitProfileImage.path))
                                        as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getProfileImage();
                                      },
                                      icon: const Icon(IconBroken.Camera))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    Row(
                      children: [

                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                SocialCubit.get(context)
                                    .uploadCoverImage(
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    bio: bioController.text);
                              },
                              child: Text("update cover"),
                            )),

                        SizedBox(
                          width: 8,
                        ),
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            SocialCubit.get(context).uploadProfleImage(
                                phone: phoneController.text,
                                name: nameController.text,
                                bio: bioController.text);
                          },
                          child: Text("update image"),
                        )),
                      ],
                    ),




                  const SizedBox(
                    height: 9,
                  ),
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReusableTextForm(
                      TextController: nameController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(IconBroken.User),
                    ),
                  ),
                  //SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReusableTextForm(
                      TextController: bioController,
                      labelText: 'Bio',
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(IconBroken.Info_Circle),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReusableTextForm(
                      TextController: phoneController,
                      labelText: 'PHONE',
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(IconBroken.Info_Circle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
