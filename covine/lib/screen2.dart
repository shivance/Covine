import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2 createState() => _Screen2();
}

class _Screen2 extends State<Screen2> {
  List<String> logs = [];
  final myController = TextEditingController();

  var date = new DateTime.now().toString();
  var dateParse, fd;

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
      body: new Column(
        children: <Widget>[
          Text(
            "LOGS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Phone',
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
                  onPressed: () {
                    setState(() {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                    });
                    _addTodoItem();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
        child: Icon(Icons.add_comment),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 4,
      color: Color.fromRGBO(64, 75, 96, .9),
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
                Text("Log $index", style: TextStyle(color: Colors.white70)),
                Text("$fd", style: TextStyle(color: Colors.white70)),
              ],
            ),
            Spacer(),
            CircleAvatar(backgroundColor: Colors.white),
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

  /* void _showDialog() {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          createLog();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }*/
}
