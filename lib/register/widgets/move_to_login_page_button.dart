import 'package:flutter/material.dart';
import 'package:tasker/common/user_repository.dart';
import 'package:tasker/screens/login_screen.dart';

class MoveToLoginPageButton extends StatelessWidget {
  final UserRepository _userRepository;

  MoveToLoginPageButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Log In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen(userRepository: _userRepository);
            },
          ),
        );
      },
    );
  }
}
