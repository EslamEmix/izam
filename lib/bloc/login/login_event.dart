part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SubmitLoginEvent implements LoginEvent {
  final String email, password;

  SubmitLoginEvent(this.email, this.password);
}
