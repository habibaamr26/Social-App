

abstract class LoginStates{}

class InitialState extends LoginStates{}

class ChangeScure extends LoginStates{}

class LoadingLogin extends LoginStates{}
class SuccessLogin extends LoginStates{}
class FailLogin extends LoginStates{
  String x;
  FailLogin(this.x);
}


