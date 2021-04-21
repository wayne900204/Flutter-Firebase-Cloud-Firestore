import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database_realtime/screens/add_user_dialog.dart';
import 'package:flutter/material.dart';
class HomeList extends StatelessWidget {
  final List data;
  HomeList({this.data});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
                child: new Center(
                  child: new Row(
                    children: <Widget>[
                      new CircleAvatar(
                        radius: 30.0,
                        child: new Text(_getShortName(data[index])),
                        backgroundColor: const Color(0xFF20283e),
                      ),
                      new Expanded(
                        child: new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                data[index]['FirstName'] +
                                    " " +
                                    data[index]['LastName'],
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlueAccent),
                              ),
                              // new Text(
                              //   "DATE: " + data[index].dob,
                              //   // set some style to text
                              //   style: new TextStyle(
                              //       fontSize: 20.0, color: Colors.amber),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: const Color(0xFF167F67),
                            ),
                            onPressed: () => edit(context,index),
                          ),

                          new IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: const Color(0xFF167F67)),
                            onPressed: () async {
                              await deleteData(index);
                            }
                                // homePresenter.delete(_listData[index]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });
  }
  String _getShortName(QueryDocumentSnapshot map) {
    String shortName = "";
    if(map["FirstName"].toString().isNotEmpty)
    shortName = map["FirstName"].substring(0, 1) + ".";
    if(map["LastName"].toString().isNotEmpty)
    shortName = shortName + map["LastName"].substring(0, 1);
    return shortName;
  }
  deleteData(int index)async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserName');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[index].reference.delete();
  }

  edit( BuildContext context,int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
           AddUserDialog().buildAboutDialog(context, this, true,index),
    );
  }
}
