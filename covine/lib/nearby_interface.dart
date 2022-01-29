import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:page_transition/page_transition.dart';
import 'package:covine/screen1.dart';
import 'package:covine/screen2.dart';
import 'package:covine/screen3.dart';

import 'package:covine/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NearbyInterface extends StatefulWidget {
  static const String id = 'nearby_interface';

  final String email; //if you have multiple values add here
  NearbyInterface(this.email, {Key key}) : super(key: key);
  @override
  _NearbyInterfaceState createState() => _NearbyInterfaceState();
}

class _NearbyInterfaceState extends State<NearbyInterface> {
  Location location = Location();
  Firestore _firestore = Firestore.instance;
  final Strategy strategy = Strategy.P2P_STAR;
  FirebaseUser loggedInUser;
  String testText = '', emaill = '';
  final _auth = FirebaseAuth.instance;
  List<dynamic> contactTraces = [];
  List<dynamic> contactTimes = [];
  List<dynamic> contactLocations = [];
  //State class
  int page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int currentIndex = 0;
  final globalKey = GlobalKey<ScaffoldState>();

  final List<Widget> viewContainer = [
    Screen1(),
    Screen2(),
    Screen3()
    //VideoContainerScreen(),
    //AlbumContainerScreen()
  ];

  void addContactsToList() async {
    await getCurrentUser();
    _firestore
        .collection('users')
        .document(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
        String currUsername = doc.data['username'];
        DateTime currTime = doc.data.containsKey('contact time')
            ? (doc.data['contact time'] as Timestamp).toDate()
            : null;
        String currLocation = doc.data.containsKey('contact location')
            ? doc.data['contact location']
            : null;

        if (!contactTraces.contains(currUsername)) {
          contactTraces.add(currUsername);
          contactTimes.add(currTime);
          contactLocations.add(currLocation);
        }
      }
      setState(() {});
      print(loggedInUser.email);
    });
  }

  // Sign Out Method
  _signOut() async {
    await _auth.signOut();
  }

  void deleteOldContacts(int threshold) async {
    await getCurrentUser();
    DateTime timeNow = DateTime.now(); //get today's time

    _firestore
        .collection('users')
        .document(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
//        print(doc.data.containsKey('contact time'));
        if (doc.data.containsKey('contact time')) {
          DateTime contactTime = (doc.data['contact time'] as Timestamp)
              .toDate(); // get last contact time
          // if time since contact is greater than threshold than remove the contact
          if (timeNow.difference(contactTime).inDays > threshold) {
            doc.reference.delete();
          }
        }
      }
    });

    setState(() {});
  }

  void discovery() async {
    try {
      bool a = await Nearby().startDiscovery(loggedInUser.email, strategy,
          onEndpointFound: (id, name, serviceId) async {
        print('I saw id:$id with name:$name'); // the name here is an email

        var docRef =
            _firestore.collection('users').document(loggedInUser.email);

        //  When I discover someone I will see their email and add that email to the database of my contacts
        //  also get the current time & location and add it to the database
        docRef.collection('met_with').document(name).setData({
          'username': await getUsernameOfEmail(email: name),
          'contact time': DateTime.now(),
          'contact location': (await location.getLocation()).toString(),
        });
      }, onEndpointLost: (id) {
        print(id);
      });
      print('DISCOVERING: ${a.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void getPermissions() {
    Nearby().askLocationAndExternalStoragePermission();
  }

  Future<String> getUsernameOfEmail({String email}) async {
    String res = '';
    await _firestore.collection('users').document(email).get().then((doc) {
      if (doc.exists) {
        res = doc.data['username'];
        print("Here ----- " + res);
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return res;
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        emaill = loggedInUser.email;
        print("YOYO -  $widget.email");
      }
    } catch (e) {
      print(e);
    }
  }

  //Future navigateToSubPage(context) async {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //}

  @override
  void initState() {
    super.initState();
    deleteOldContacts(14); // Delete if 14 days old
    addContactsToList();
    getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    /*  void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }*/

    return Scaffold(
      key: globalKey,
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              accountName: new Text(
                "${widget.email}",
                style: new TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: new Text(
                "UID : ${loggedInUser.uid}",
                style: new TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: AssetImage("images/user.jpg")),
              otherAccountsPictures: <Widget>[
                Container(
                  height: 80,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
            new ListTile(
                leading: Icon(Icons.help),
                title: new Text(
                  "About",
                  style: new TextStyle(
                    fontSize: 15.5,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  //   Navigator.of(context).push(
                  //   PageTransitionsTheme(),
                  //);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 400),
                      child: Home(),
                    ),
                  );
                  //  Navigator.of(context).push(createRoute());
                  //   navigateToSubPage(context);
                }),
            new ListTile(
                leading: Icon(Icons.book),
                title: new Text(
                  "Export Logs",
                  style: new TextStyle(
                    fontSize: 15.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Alert(
                    context: context,
                    type: AlertType.success,
                    title: "Push Data via Mesh",
                    desc:
                        "Data will be synced back and forth, and logs will be submitted",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          final snackBar = SnackBar(
                              content: Text('Data is being pushed ...'));
                          globalKey.currentState.showSnackBar(snackBar);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                }),
            new ListTile(
                leading: Icon(Icons.report),
                title: new Text(
                  "Report (Infected)",
                  style: new TextStyle(
                    fontSize: 15.5,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                  final snackBar = SnackBar(
                      content: Text(
                          'Go to the middle bottom navigation tab, for reporting!'));
                  globalKey.currentState.showSnackBar(snackBar);
                }),
            new ListTile(
                leading: Icon(Icons.settings),
                title: new Text(
                  "Settings",
                  style: new TextStyle(
                    fontSize: 15.5,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final snackBar =
                      SnackBar(content: Text('Limited to DEVELOPERS ONLY....'));
                  globalKey.currentState.showSnackBar(snackBar);
                }),
            new Divider(),
            new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text(
                  "Logout",
                  style: new TextStyle(
                    fontSize: 15.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _signOut();
                  //  Navigator.popUntil(context, ModalRoute.withName("/"));
                  Navigator.of(context, rootNavigator: true).pop(context);
                }),
          ],
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.deepPurple,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: Text('Covine',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
            )),
        backgroundColor: Colors.white,
      ),
      body: viewContainer[page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.home, size: 23),
          Icon(Icons.message, size: 23),
          Icon(Icons.supervised_user_circle, size: 23),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}

// TODO: Take mobile number instead of email

// TODO: Delete contacts older than 14 days from database
