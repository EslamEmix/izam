part of 'login_bloc.dart';

abstract class LoginBaseRepo {
  Future<LoginState> getUser(String email, String password);
}

class LoginLocalDatabase implements LoginBaseRepo {
  @override
  Future<LoginState> getUser(String email, String password) async {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    User? dbUser = await databaseHelper.getUser(email, password);
    if (dbUser == null) {
      User? newUser =
          await databaseHelper.addUser(User(email: email, password: password));
      if (newUser != null) {
        return LoginSuccessState(newUser);
      } else {
        return LoginErrorState("Something goes wrong");
      }
    } else {
      dbUser.loginCount++;
      await databaseHelper.updateUser(dbUser);
      return LoginSuccessState(dbUser);
    }
  }
}
