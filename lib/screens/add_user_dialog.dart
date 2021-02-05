import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUserDialog {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  int index;
  Widget buildAboutDialog(BuildContext context, _myHomePageState, bool isEdit,int index) {
    if (index != null) {
      this.index=index;
    }
    return AlertDialog(
      title: Text(isEdit ? 'Edit' : 'Add new User'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Enter first name", _firstNameController),
            getTextField("Enter last name", _lastNameController),
            new GestureDetector(
              onTap: () {
                dialogOnTap(isEdit);
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }
  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }
  dialogOnTap(isEdit){
    if(_firstNameController.text.isEmpty||_lastNameController.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Account and Password can't not be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black45,
          fontSize: 16.0);
    }else{
      if(isEdit){
        upData();
      }else {
        addData();
      }
    }
  }
  addData() {
    Map<String, dynamic> demoData = {
      "FirstName": _firstNameController.text,
      "LastName": _lastNameController.text
    };
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('UserName');
      collectionReference.add(demoData);
  }
  upData()async{
    Map<String, dynamic> demoData = {
      "FirstName": _firstNameController.text,
      "LastName": _lastNameController.text
    };
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserName');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[index].reference.update(demoData);
  }
}
