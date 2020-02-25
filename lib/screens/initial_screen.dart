import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tasker/common/database_repository.dart';
import 'package:tasker/common/user_repository.dart';
import 'package:tasker/screens/home_screen.dart';

import 'package:tasker/authentication/bloc/bloc.dart';
import 'package:tasker/screens/login_screen.dart';

class InitialScreen extends StatelessWidget {
  static const String routeName = '/';
  final UserRepository _userRepository;

  InitialScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseRepository>(create: (_) => DatabaseRepository()),
        Provider<UserRepository>(create: (_) => UserRepository())
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state);
          if (state is Uninitialized) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(
              userId: _userRepository.getUserId(),
            );
          }
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          return Container();
        },
      ),
    );
  }
}
