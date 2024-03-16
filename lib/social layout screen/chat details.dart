

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/app_cubit/social_cubit.dart';
import 'package:social_app/models/chat%20model.dart';

import '../app_cubit/social_status.dart';
import '../models/model.dart';

class ChatDetails extends StatelessWidget {

  late UserModel usersCubit;
  ChatDetails({required this.usersCubit});
var textControlle=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverID:usersCubit.UID );
        SocialCubit.get(context).setUserMessage(
            receiverID: usersCubit.UID,
            text: "",
            date: DateTime.now().toString());

        return BlocConsumer<SocialCubit,SocialStates>(
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        "${usersCubit.image}",
                      ),
                    ),
                    const SizedBox(
                      width: 15,
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
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child:Column(
                  children: [
                    Expanded(
                      child: ListView.separated (
                       itemBuilder: (BuildContext context, int index) {
                         var messag=SocialCubit.get(context).message[index];
                         if(messag.senderID==SocialCubit.get(context).model!.UID)
                           {
                             return senderMessage(messag);
                           }

                             return receiverMessage(messag);

                       },
                      separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 10,),
                      itemCount: SocialCubit.get(context).message.length,
                  ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(

                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type your message here ..."
                                ),
                                controller: textControlle,
                              ),
                            ),

                            Container(
                              color: Colors.blue,
                              child: MaterialButton(onPressed: (){
                                SocialCubit.get(context).setUserMessage(
                                    receiverID: usersCubit.UID,
                                    text: textControlle.text,
                                    date: DateTime.now().toString());
                              },
                                minWidth: 1,
                                child: Icon(IconBroken.Send,size: 16,color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    
                  ]
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {  },

        );
      },

    );
  }
}


Widget receiverMessage(ChatModel message)=> Align(
  alignment: AlignmentDirectional.topStart,
  child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      decoration: BoxDecoration(
          color:Colors.grey[300],
          borderRadius:BorderRadius.only(topRight:Radius.circular(10) ,
              topLeft: Radius.circular(10) ,bottomRight: Radius.circular(10) )
      ),
      child: Text(message.text)),
);



Widget senderMessage(ChatModel message)=>Align(
  alignment: AlignmentDirectional.topEnd,
  child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      decoration: BoxDecoration(
          color:Colors.blue.withOpacity(0.2),
          borderRadius:const BorderRadius.only(topRight:Radius.circular(10) ,
              topLeft: Radius.circular(10) ,bottomRight: Radius.circular(10) )
      ),
      child: Text(message.text)),
);






