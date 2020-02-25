import 'package:flutter/material.dart';
import 'package:tasker/common/user_repository.dart';
import 'package:tasker/screens/register_screen.dart';

class MoveToRegisterPageButton extends StatelessWidget {
  final UserRepository _userRepository;

  MoveToRegisterPageButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RegisterScreen(userRepository: _userRepository);
            },
          ),
        );
      },
    );
  }
}
