
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/app_cubit/social_status.dart';
import 'package:social_app/social%20layout%20screen/chat_screen.dart';
import 'package:social_app/social%20layout%20screen/home_screen.dart';
import 'package:social_app/social%20layout%20screen/location_screen.dart';
import 'package:social_app/social%20layout%20screen/setting_screen.dart';

import '../consistency.dart';
import '../models/chat model.dart';
import '../models/post model.dart';
import '../social layout screen/post_screen.dart';
import '../models/model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void GetDataToShow() {
    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {
      print(value.data());
      model = UserModel.formJason(value.data());
      print(model!.bio);
      emit(GetUserDataSuccess());
    }).catchError((e) {
      print("eeeeeeee${e}");
      emit(GetUserDataFail());
    });
  }

  List<Widget> Screens = [
    HomeScreen(),
    ChatScreen(),
    PostScreen(),
    LocationScreen(),
    SettingScreen(),
  ];

  List<Widget> appBarTitel = [
    const Text(
      'News Feed',
    ),
    const Text("Chats"),
    const Text("Poste"),
    const Text("Users"),
    const Text("Settings"),
  ];

  int bottomNavigationCurrent = 0;
  void bottomNavigationCurrentChange(int index) {
    if (index == 2) {
      emit(AddPostSate());
    }
    else {
      if(index==1)
        getAllUsrs();
      bottomNavigationCurrent = index;
      emit(changeBottomBar());
    }
  }

  //to pick a cover photo from your mobile
  File? coverImage;
  final ImagePicker picker = ImagePicker();
  getCoverImage() async {
    final XFile? image = (await picker.pickImage(source: ImageSource.gallery));

    if (image != null) {
      coverImage = File(image.path);
      print(image.path);
      emit(CoverChangeStateSuccess());
    } else {
      print("NO picked Photo");
      emit(CoverChangeStateError());
    }
  }

//to pick a profile photo from your mobile
  File? profileImage; //الصوره اللي اختارتها
  getProfileImage() async {
    final XFile? image = (await picker.pickImage(source: ImageSource.gallery));

    if (image != null) {
      profileImage = File(image.path);
      print(image.path);
      emit(PickProfilePhotoStateSuccess());
    } else {
      print("NO picked Photo");
      emit(PickProfilePhotoStateError());
    }
  }

// upload profile photo to fire storage and get download uri
  // and then send this uri to firestorage by calling function update to update in firestore

  void uploadProfleImage({
    required String phone,
    required String name,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        UbdateFireBase(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      }).catchError((e) {
        emit(ChangeProfilePhotoStateError());
      });
    }).catchError((e) {
      emit(ChangeProfilePhotoStateError());
    });
  }

// upload cover photo to fire storage and get download uri
  // and then send this uri to firestorage by calling function update to update in firestore
  void uploadCoverImage({
    required String phone,
    required String name,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        UbdateFireBase(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      }).catchError((e) {
        emit(ChangeCoverPhotoStateError());
      });
    }).catchError((e) {
      emit(ChangeCoverPhotoStateError());
    });
  }

  // to update data in firestore

  UbdateFireBase({
    required String phone,
    required String name,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel updateUserModel = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        email: model!.email,
        UID: model!.UID,
        cover: cover ?? model!.cover,
        image: image ?? model!.image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .update(updateUserModel!.ToMap())
        .then((value) {
      GetDataToShow();
    }).catchError((e) {
      emit(UpdateUserDataError());
    });
  }

  File? PostImage; //الصوره اللي اختارتها
  getPostImage() async {
    final XFile? image = (await picker.pickImage(source: ImageSource.gallery));

    if (image != null) {
      PostImage = File(image.path);
      emit(PickProfilePhotoStateSuccess());
    } else {
      emit(PickProfilePhotoStateError());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        creatPostImage(dateTime: dateTime, text: text,postImage: value);

      }).catchError((e) {
        emit(uploadPostImageErrorState());
      });
    }).catchError((e) {
      emit(uploadPostImageErrorState());
    });
  }

  void creatPostImage({
    required String dateTime,
    required String text,
    String? postImage,
  }) {

    emit(CreatePostLoadingState());
    PostModel post = PostModel(
        name: model!.name,
      UID: model!.UID,
        dateTime: dateTime,
        image: model!.image,
        text: text,
        postPhoto: postImage??"",
    );


    FirebaseFirestore.
    instance.
    collection('posts').
    add(post.ToMap()).
    then((value) {
      emit(CreatePostSuccessState());
    }).catchError((e){
      emit(CreatePostErrorState());
    });
  }


  void removePostImage()
  {
    PostImage=null;
   emit(RemovePostStateState());
  }
  
  // to get all posts in database
  List<PostModel> posts=[];
  List<String> postId=[];

  List <int> postsLike=[];

  void getPosts()
{
  FirebaseFirestore.instance.
  collection('posts').
  get().then((value) {
    value.docs.forEach((element) {
      element.reference.collection('likes').get().then((value) {
        postsLike.add(value.docs.length);
        postId.add(element.id);
        posts.add(PostModel.formJason(element.data()));
      }).catchError((e){
      });

    });
    emit(GetPostSuccessState());
  }).catchError((){
    emit(GetPostErrorState());
  });
}



void postLikes(
  {
    required String postId,
}
    )
{
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(model!.UID).set({
    'like':true
  })
      .then((value) {
        emit(GetPostLikeSuccessState());
  })
      .catchError((e){
        emit(GetPostLikeErrorState());
  });


}








  List<UserModel> allModels=[];
void getAllUsrs(){
  allModels=[];
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if(element.data()['UID']!=model!.UID) {
              allModels.add(UserModel.formJason(element.data()));
            }
          });
          emit(GetAllUsersSuccessState());
    }).catchError((e){

      emit(GetAllUsersErrorState());
    });
}


// set sender message
void setUserMessage({
    required String receiverID,
    required String text,
  required String date,
})
{
  var messageModel=ChatModel
    (senderID: model!.UID, recieverID: receiverID, date: date, text: text);

  FirebaseFirestore.instance
      .collection('users')
      .doc(model!.UID)
      .collection('chat')
      .doc(receiverID)
      .collection('message')
      .add(messageModel.toMap())
  .then((value) {
    emit(SetMassegeSuccessState());
  }).catchError((e){
    emit(SetMassegeErrorState());
  });


//set recever message
  // must be save in 2 chats
  //si you save it in 2 places in firebase
  FirebaseFirestore.instance
      .collection('users')
      .doc(receiverID)
      .collection('chat')
      .doc(model!.UID)
      .collection('message')
      .add(messageModel.toMap())
      .then((value) {
    emit(SetMassegeSuccessState());
  }).catchError((e){
    emit(SetMassegeErrorState());
  });
}

  List <ChatModel> message=[];


void getMessages(
  {
    required String receiverID,
}
    )
{

  FirebaseFirestore.instance
.collection('users').doc(model!.UID)
.collection('chat')
.doc(receiverID).collection('message')
      .orderBy('date').snapshots().listen((event) {
    message=[];
        event.docs.forEach((element) {
          message.add(ChatModel.formJason(element.data()));
        });
  });
}




}










