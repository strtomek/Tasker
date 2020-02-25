import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasker/authentication/bloc/authentication_bloc.dart';
import 'package:tasker/authentication/bloc/authentication_event.dart';
import 'package:tasker/screens/home_screen.dart';

import 'package:tasker/screens/initial_screen.dart';

import 'common/user_repository.dart';

void main() async {
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
      builder: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: InitialScreen(
        userRepository: _userRepository,
      ),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
