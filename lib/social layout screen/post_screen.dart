import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/app_cubit/social_cubit.dart';
import 'package:social_app/app_cubit/social_status.dart';

class PostScreen extends StatelessWidget {

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Creat Post"),
            titleSpacing: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: TextButton(onPressed: () {
                  if(SocialCubit.get(context).PostImage==null) {
                    SocialCubit.get(context).creatPostImage
                      (dateTime:DateTime.now().toString() ,
                        text: textController.text
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(dateTime:DateTime.now().toString() , text: textController.text);
                  }

                }, child: const Text("POST")),
              )
            ],
          ),


          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                CircularProgressIndicator(),
                if(state is CreatePostLoadingState)
                SizedBox(height: 10,),
                Row(
                  children: [

                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        SocialCubit.get(context).model!.image,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        SocialCubit.get(context).model!.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),

                Expanded(child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "what is on your mind ...",
                    border:InputBorder.none,
                  ),
                )),


                if(SocialCubit.get(context).PostImage!=null) Stack(
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
                              image: FileImage(
                                SocialCubit.get(context).PostImage as File
                              ),
                              fit: BoxFit.cover)),
                    ),
                    IconButton(onPressed:(){
                      SocialCubit.get(context).PostImage;
                      SocialCubit.get(context).removePostImage;
                      SocialCubit.get(context).PostImage;
                    },icon: Icon(IconBroken.Delete,size: 18,)),
                  ],
                ),

                SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      },child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Camera),
                          SizedBox(width: 5,),
                          Text("Add Photo"),
                        ],
                      ),),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},child: const Text("#Tags"),),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}
