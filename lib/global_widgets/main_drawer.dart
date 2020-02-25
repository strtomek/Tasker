import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tasker/authentication/bloc/bloc.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(50),
              color: Colors.white,
            ),
            width: 100,
            height: 100,
            child: Icon(
              Icons.perm_identity,
              color: Colors.black,
              size: 90,
            ),
          ),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 12),
          Text(
            'Current project name',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          DrawerMainMenu(),
          Container(
            margin: EdgeInsets.all(15),
            height: 40,
            width: 200,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: Text(
                'SIGN OUT',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
          )
        ],
      ),
    );
  }
}

class DrawerMainMenu extends StatelessWidget {
  const DrawerMainMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.storage,
              color: Colors.white,
            ),
            title: Text(
              'Projects',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            title: Text(
              'Messages',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
