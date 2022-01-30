import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covine/constants.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2 createState() => _Screen2();
}

class _Screen2 extends State<Screen2> {
  List<String> logs = [];
  Firestore _firestore = Firestore.instance;
  final myController = TextEditingController();
  String email;
  var date = new DateTime.now().toString();
  var dateParse, fd;

  void infected(String email) async {
    _firestore.collection('users').document(email).updateData({
      'contact status': 'Infected',
    });
  }

  void _addTodoItem() {
    dateParse = DateTime.parse(date);
    fd = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    setState(() {
      int index = logs.length;
      logs.add('Item ' + index.toString());
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  final _text = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: primary,
      body: new Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            "LOGS",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
          new Expanded(child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
            if (index < logs.length) {
              return _buildListItem(context, index);
            }
          }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_showDialog();
          Alert(
              context: context,
              title: "REPORT CASE",
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: _text,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Name',
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: 'Mail',
                    ),
                  ),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      icon: Icon(Icons.message),
                      labelText: 'Message',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  color: system_teal,
                  onPressed: () {
                    setState(() {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                    });
                    _addTodoItem();
                    infected(email);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        child: Icon(Icons.add_comment),
        backgroundColor: Colors.teal[300],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("${myController.text}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Log $index", style: TextStyle(color: Colors.black)),
                Text("$fd", style: TextStyle(color: Colors.black)),
              ],
            ),
            Spacer(),
            CircleAvatar(backgroundColor: Colors.grey),
          ],
        ),
      ),
    );
  }

  Card createLog() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
