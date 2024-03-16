import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social%20screen/register/register_states.dart';

import '../../models/model.dart';

class registerCubit extends Cubit<registerStates> {
  registerCubit() : super(InitialState());

  static registerCubit get(context) => BlocProvider.of(context);

  void CreatUserData({
    required String email,
    required String name,
    required String UID,
    required String phone,
  }) {
    emit(LoadingData());
    UserModel UserData = UserModel(
        email: email,
        phone: phone,
        name: name,
        UID: UID,
        cover: 'https://img.freepik.com/free-photo/study-group-learning-library_23-2149215380.jpg?w=1060&t=st=1696789609~exp=1696790209~hmac=b838c85cff75f165f1d27d8ffe6b5c6f492ae94193326ace062a798073796c9a',
        image: 'https://img.freepik.com/free-photo/handsome-barista-black-apron-pointing-finger-mobile-screen-showing-app-smiling-standing-yellow-background_1258-73692.jpg?w=1060&t=st=1696789457~exp=1696790057~hmac=d97a32026b78e40fd519491542a7bcee43d8a68f3c2028ad980fc7b7ed264e56',
        bio: 'enter your bio ...',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .set(UserData.ToMap())
        .then((value) {
          print("datagoaa ");
      emit(SuccessData());
    }).catchError((e) {
      print("rrrrrrrrrrrrrrrrrrrrr${e}");
      emit(FailData());
    });
  }

  void UserData({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(LoadingUserData());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CreatUserData(
          email: email, name: name, UID: value.user!.uid, phone: phone);
      emit(SuccessUserData());
    }).catchError((e) {
      print(e);
      emit(FailUserData());
    });
  }

  bool isScure = false;

  void ChangeisScure() {
    isScure = !isScure;
    emit(ChangeScure());
  }
}
