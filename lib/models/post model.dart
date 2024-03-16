

import 'dart:core';
class PostModel {
  late String name;
  late String UID;
  late String image;
  late String dateTime;
  late String text;
  late String postPhoto;

  PostModel({
    required this.name,required this.UID,
    required this.dateTime,required this.image,
    required this.text, required this.postPhoto,
  });

  PostModel.formJason(Map<String,dynamic>? jason)
  {
    name=jason?['name'];
    dateTime=jason?['dateTime'];
    text=jason?['text'];
    UID=jason?['UID'];
    image=jason?['image'];
    postPhoto=jason?['postPhoto'];
  }


  Map<String,dynamic> ToMap()
  {
    return {
      'name':name,
      'text':text,
      'dateTime':dateTime,
      'UID':UID,
      'image':image,
      'postPhoto':postPhoto,

    };
  }
}