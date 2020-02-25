import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tasker/common/database_repository.dart';
import 'package:tasker/common/user_repository.dart';
import 'package:tasker/global_widgets/main_drawer.dart';
import 'package:tasker/global_widgets/todo_task_card.dart';
import 'package:tasker/models/user.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';
  Future<String> userId;

  HomeScreen({this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    DatabaseRepository databasRepository =
        Provider.of<DatabaseRepository>(context);

    UserRepository userRepository = Provider.of<UserRepository>(context);

    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document('${widget.userId}')
          .snapshots(),
      builder: (context, snapshot) => Scaffold(
        key: _scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: MainDrawer(),
        ),
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  print(userRepository.getUserId());
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
            elevation: 5,
            backgroundColor: Colors.red[900],
            title: Center(
              child: Text(
                'Room/Project name',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: databasRepository.getUsersProjects('${widget.userId}') == null
            ? TasksList()
            : Container(),
        // body: TasksList(),
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  const TasksList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'TODO:',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (ctx, index) => TodoTaskCard(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'In Progress:',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}
