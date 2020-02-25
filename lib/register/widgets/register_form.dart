import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasker/authentication/bloc/bloc.dart';
import 'package:tasker/common/user_repository.dart';
import 'package:tasker/register/bloc/bloc.dart';
import 'package:tasker/register/widgets/move_to_login_page_button.dart';
import 'package:tasker/register/widgets/register_button.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();

  final UserRepository _userRepository;

  RegisterForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red[400],
                    Color.fromRGBO(116, 26, 22, 1),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              controller: _emailController,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.mail)),
                              autovalidate: true,
                              autocorrect: true,
                              cursorColor: Colors.white,
                              validator: (_) {
                                return !state.isEmailValid
                                    ? 'Invalid Email'
                                    : null;
                              },
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Password:',
                                prefixIcon: Icon(Icons.vpn_key),
                              ),
                              obscureText: true,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (_) {
                                return !state.isPasswordValid
                                    ? 'Invalid Password'
                                    : null;
                              },
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _firstnameController,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'First Name',
                                prefixIcon: Icon(Icons.mail),
                              ),
                              autovalidate: true,
                              autocorrect: true,
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _lastNameController,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: 'Last Name',
                                  prefixIcon: Icon(Icons.mail)),
                              autovalidate: true,
                              autocorrect: true,
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),
                        RegisterButton(
                          onPressed: isRegisterButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                        ),
                        MoveToLoginPageButton(
                          userRepository: widget._userRepository,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstnameController.text,
        lastName: _lastNameController.text,
      ),
    );
  }
}
