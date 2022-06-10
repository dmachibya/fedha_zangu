import 'package:fedha_zangu/utils/auth.dart';
import 'package:fedha_zangu/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final db = FirebaseFire
  final db = FirebaseFirestore.instance;

  // var now = new DateTime.now();
  var today = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    print(today);
    super.initState();
  }
  // String formattedDate = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Container(
      padding:
          EdgeInsets.symmetric(vertical: 20, horizontal: paddingRatio * width),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Habari",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.w200),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: db
                  .collection("users")
                  .doc(AuthenticationHelper().user.uid)
                  .get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }
                if (snapshot.hasError) {
                  return Text("There was an error");
                }
                return Text(
                  snapshot.data!.get('name'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.w900),
                );
              }),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade500,
                    Colors.deepPurple.shade800,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    "Kiasi kilichopo",
                    style: TextStyle(color: Colors.white),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection("flow")
                          .where("uid",
                              isEqualTo: AuthenticationHelper().user.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        }
                        if (snapshot.hasError) {
                          return Text("There was an error");
                        }
                        if (!snapshot.hasData) {
                          return Text("There was an error");
                        }
                        if (snapshot.data!.docs.length < 1) {
                          return Text("TZS 000");
                        }

                        var items = snapshot.data!.docs;
                        var total = 0;

                        for (var element in items) {
                          if (element.get('type') == 1) {
                            total += int.parse(element.get('amount'));
                          } else if (element.get('type') == 2) {
                            total -= int.parse(element.get('amount'));
                          }
                        }

                        return Text("TZS $total/=",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold));
                      }),
                  Spacer(),
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Icon(Icons.calendar_month, size: 16, color: Colors.black),
              SizedBox(
                width: 8,
              ),
              Text(
                today,
                // today.toString(),""
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("flow")
                  .where("uid", isEqualTo: AuthenticationHelper().user.uid)
                  .where('date', isEqualTo: today)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }
                if (snapshot.hasError) {
                  return Text("There was an error");
                }
                if (!snapshot.hasData) {
                  return Text("There was an error");
                }
                if (snapshot.data!.docs.length < 1) {
                  return Text("TZS 000");
                }

                var items = snapshot.data!.docs;
                var total = 0;

                for (var element in items) {
                  if (element.get('type') == 1) {
                    total += int.parse(element.get('amount'));
                  }
                }

                return Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    child: Row(children: [
                      const Text(
                        "Mapato",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      Text(
                        "TZS $total",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 28,
                      )
                    ]),
                  ),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("flow")
                  .where('date', isEqualTo: today)
                  .where("uid", isEqualTo: AuthenticationHelper().user.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }
                if (snapshot.hasError) {
                  return Text("There was an error");
                }
                if (!snapshot.hasData) {
                  return Text("There was an error");
                }
                if (snapshot.data!.docs.length < 1) {
                  return Text("TZS 000");
                }

                var items = snapshot.data!.docs;
                var total = 0;

                for (var element in items) {
                  if (element.get('type') == 2) {
                    total += int.parse(element.get('amount'));
                  }
                }

                return Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    child: Row(children: [
                      Text(
                        "Matumizi",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "TZS $total",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 28,
                      )
                    ]),
                  ),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("flow")
                  .where("uid", isEqualTo: AuthenticationHelper().user.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }
                if (snapshot.hasError) {
                  return Text("There was an error");
                }
                if (!snapshot.hasData) {
                  return Text("There was an error");
                }
                if (snapshot.data!.docs.length < 1) {
                  return Text("TZS 000");
                }

                var items = snapshot.data!.docs;
                var total = 0;

                for (var element in items) {
                  if (element.get('type') == 4) {
                    total += int.parse(element.get('amount'));
                  }
                }

                return Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    child: Row(children: [
                      Text(
                        "Unachodaiwa",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "TZS $total",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 28,
                      )
                    ]),
                  ),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("flow")
                  .where("uid", isEqualTo: AuthenticationHelper().user.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }
                if (snapshot.hasError) {
                  return Text("There was an error");
                }
                if (!snapshot.hasData) {
                  return Text("There was an error");
                }
                if (snapshot.data!.docs.length < 1) {
                  return Text("TZS 000");
                }

                var items = snapshot.data!.docs;
                var total = 0;

                for (var element in items) {
                  if (element.get('type') == 3) {
                    total += int.parse(element.get('amount'));
                  }
                }

                return Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    child: Row(children: [
                      Text(
                        "Unachodai",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "TZS $total",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 28,
                      )
                    ]),
                  ),
                );
              })
        ],
      ),
    ));
  }
}
