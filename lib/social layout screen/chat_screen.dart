
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/app_cubit/social_cubit.dart';
import 'package:social_app/app_cubit/social_status.dart';
import 'package:social_app/models/model.dart';

import 'chat details.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state) {
        var usersCubit=SocialCubit.get(context);
        return ConditionalBuilder(
          condition:usersCubit.allModels!=null ,
          builder: (BuildContext context) { return ListView.separated(
              itemBuilder: (context,index)=> itemBuilder(context,usersCubit.allModels[index]),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(width: double.infinity,
                  height: 2,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: usersCubit.allModels.length
          ); },
          fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),

        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}


Widget itemBuilder(context,UserModel usersCubit)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_){
        return ChatDetails(usersCubit: usersCubit,);
      }));
    },
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "${usersCubit.image}",
          ),
        ),
        const SizedBox(
          width: 10,
        ),

        Text(
          "${usersCubit.name}",
          style: Theme.of(context)
              .textTheme
              .headlineSmall,
        ),
      ],
    ),
  ),
);