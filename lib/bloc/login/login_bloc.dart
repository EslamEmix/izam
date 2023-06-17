import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:izam_task/helper/database_helper.dart';
import 'package:meta/meta.dart';
import 'package:izam_task/model/User.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginBaseRepo _repo = LoginLocalDatabase();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SubmitLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      emit(await _repo.getUser(event.email, event.password));
    });
  }
}
