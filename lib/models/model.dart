



import 'dart:core';
class UserModel
{
  late String name;
  late  String email;
  late String phone;
  late String cover;
  late String UID;
  late String image;
  late  String bio;
   UserModel({
      required this.email,
     required this.phone,required this.name,required this.UID,
     required this.cover,required this.image,
     required this.bio
});

   UserModel.formJason(Map<String,dynamic>? jason)
   {
     name=jason?['name'];
     email=jason?['email'];
     phone=jason?['phone'];
     cover=jason?['cover'];
     UID=jason?['UID'];
     image=jason?['image'];
     bio=jason?['bio'];
   }


   Map<String,dynamic> ToMap()
   {
     return {
       'name':name,
       'email':email,
       'phone':phone,
       'UID':UID,
       'image':image,
       'bio':bio,
       'cover':cover,

     };
   }
}