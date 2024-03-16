

import 'dart:core';

class ChatModel
{
 late String senderID;
  late String recieverID;
  late String date;
 late String text;
 ChatModel({
   required this.senderID,
   required this.recieverID,
   required this.date,
   required this.text,
});

 ChatModel.formJason(Map<String,dynamic> jason)
 {
   senderID=jason['senderID'];
   recieverID=jason['recieverID'];
   date=jason['date'];
   text=jason['text'];
 }

 Map<String,dynamic> toMap()
 {

     return {
       'senderID':senderID,
       'recieverID':recieverID,
       'date':date,
       'text':text,
     };

 }
}