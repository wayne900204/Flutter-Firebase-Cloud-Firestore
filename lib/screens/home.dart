import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database_realtime/widgets/home_list.dart';
import 'package:flutter/material.dart';
import 'add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text(
              'Firebase-Cloud-Firestore',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUserDialog().buildAboutDialog(context, this, false, null);
      },
    );
    setState(() {});
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
        onPressed: _openAddUserDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: _buildTitle(context),
          actions: _buildActions(),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('UserName').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Container(
                child: Text(snapshot.toString()),
              ));
            }
            if (snapshot.hasData) {
              return HomeList(data: snapshot.data.docs);
            }
            return CircularProgressIndicator();
          },
        ));
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
