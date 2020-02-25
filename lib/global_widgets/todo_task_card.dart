import 'package:flutter/material.dart';

class TodoTaskCard extends StatelessWidget {
  const TodoTaskCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.red[200],
            blurRadius: 3.0,
            spreadRadius: 1,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Task Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text('26.01.2020'),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
