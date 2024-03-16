import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/consistency.dart';

import '../../shared/shared prefrence.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void UserData({
    required String email,
    required String password,
  }) {
    emit(LoadingLogin());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UID=value.user?.uid;
      CachHelper.setdata(key: "UId", value: value.user?.uid);
      emit(SuccessLogin());
    }).catchError((e) {
      emit(FailLogin(e.toString()));
    });
  }

  bool isScure = false;

  void ChangeisScure() {
    isScure = !isScure;
    emit(ChangeScure());
  }
}
