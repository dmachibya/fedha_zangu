import 'package:fedha_zangu/screens/bajeti_detail.dart';
import 'package:fedha_zangu/screens/bajeti_mpya.dart';
import 'package:fedha_zangu/utils/auth.dart';
import 'package:fedha_zangu/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:app_popup_menu/app_popup_menu.dart';

class BajetiScreen extends StatefulWidget {
  BajetiScreen({Key? key}) : super(key: key);

  @override
  State<BajetiScreen> createState() => _BajetiScreenState();
}

class _BajetiScreenState extends State<BajetiScreen> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Bajeti Zako",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Spacer(),
              ElevatedButton(
                child: Text("Bajeti Mpya"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BajetiMpya()));
                },
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("bajeti")
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
                    return Text("No data");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data!.docs[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BajetiDetails(item: item)));
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                          item
                                                  .data()
                                                  .toString()
                                                  .contains('name')
                                              ? item.get('name')
                                              : '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      AppPopupMenu(
                                        menuItems: const [
                                          PopupMenuItem(
                                            value: 2,
                                            child: Text('View'),
                                          ),
                                          PopupMenuItem(
                                            value: 3,
                                            child: Text('Delete'),
                                          ),
                                        ],
                                        // initialValue: 2,
                                        onSelected: (int value) {
                                          // print("selected");
                                          // print(item.id);
                                          if (value == 2) {
                                            // Navigator
                                          } else if (value == 3) {
                                            // print("here inside");
                                            db
                                                .collection("bajeti")
                                                .doc(item.id)
                                                .delete();
                                          }
                                        },
                                        icon: Icon(Icons.more_vert_outlined),
                                      )
                                    ]),
                                  ],
                                ),
                              ),
                            ));
                      });
                }),
          )
        ],
      ),
    ));
  }
}
