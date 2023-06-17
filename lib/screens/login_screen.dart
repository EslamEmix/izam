import 'package:flutter/material.dart';
import 'package:izam_task/helper/app_colors.dart';
import 'package:izam_task/helper/database_helper.dart';
import 'package:izam_task/helper/input_validator.dart';
import 'package:izam_task/helper/res.dart';
import 'package:izam_task/model/User.dart';
import 'package:izam_task/screens/welcome_screen.dart';
import 'package:izam_task/widget/input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final InputValidator _inputValidator = InputValidator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 600),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Image.asset(Res.logo,
                      width: 150, height: 50, fit: BoxFit.contain),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 7.5,
                            color: Colors.black.withOpacity(.1))
                      ],
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("Welcome, log In",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                  color: AppColors.textColor)),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputWidget(
                                  "Email Address",
                                  textEditingController: _emailController,
                                  textInputType: TextInputType.emailAddress,
                                  onFieldSubmitted: (val) {
                                    // to remove white space in email field
                                    _emailController.text =
                                        val.replaceAll(" ", "");
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                  validator: (val) =>
                                      _inputValidator.emailValidator(val),
                                ),
                                InputWidget(
                                  "Password",
                                  focusNode: _passwordFocusNode,
                                  obscureText: true,
                                  textEditingController: _passwordController,
                                  validator: (val) =>
                                      _inputValidator.passwordValidator(val),
                                  onFieldSubmitted: (val) => _submitLoginForm(),
                                ),
                              ],
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Forgot Password?",
                                    style:
                                        TextStyle(color: AppColors.textColor),
                                  ))
                            ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            child: Container(
                              color: AppColors.btnColor,
                              child: ListTile(
                                onTap: _submitLoginForm,
                                textColor: Colors.white,
                                title: const Text("Login"),
                                trailing: const Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ]),
                )
              ]),
        ),
      ),
    );
  }

  _submitLoginForm() {
    if (_formKey.currentState!.validate()) {
      _login(User(
          email: _emailController.text, password: _passwordController.text));
    } else {
      _failedLogin();
    }
  }

  _login(User user) async {
    User? dbUser = await _databaseHelper.getUser(user.email, user.password);
    if (dbUser == null) {
      await _databaseHelper.addUser(user);
      _loginSuccess(user);
    } else {
      dbUser.loginCount++;
      await _databaseHelper.updateUser(dbUser);
      _loginSuccess(dbUser);
    }
  }

  _loginSuccess(User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(user: user),
        ));
  }

  _failedLogin() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Login Failed',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Text('Invalid email or password.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
