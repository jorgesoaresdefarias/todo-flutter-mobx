import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  
  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool passswordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togglePasswordVisibility() => passswordVisible = !passswordVisible;

  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedIn = true;
    email = "";
    password = "";
  }

  @action
  void logOut() => loggedIn = false;

  @computed
  Function() get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : (){};

  @computed
  bool get isPasswordValid => password.length >=6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  bool get isEmailValid => email.length >=6;


}