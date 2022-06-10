import 'package:fedha_zangu/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:fedha_zangu/utils/auth.dart';
import 'package:fedha_zangu/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_popup_menu/app_popup_menu.dart';

import 'home_nav_screen.dart';

class CashFlowScreen extends StatefulWidget {
  CashFlowScreen({Key? key}) : super(key: key);

  @override
  State<CashFlowScreen> createState() => _CashFlowScreenState();
}

class _CashFlowScreenState extends State<CashFlowScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: "Mapato"),
    Tab(text: "Matumizi"),
  ];

  late TabController _tabController;

  String mapatoError = "";
  String mapatoError2 = "";
  bool mapatoButtonClicked = false;
  bool mapatoButtonClicked2 = false;

  TextEditingController chanzoController = TextEditingController();
  TextEditingController sababuController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController amountController2 = TextEditingController();
  TextEditingController selectedBookingDateController = TextEditingController();
  TextEditingController selectedBookingDateController2 =
      TextEditingController();

  String? categoryValue = "Cash";
  String? categoryValue2 = "Cash";

  bool dataFilter = false;
  bool dataFilter2 = false;

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: width,
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.deepPurple,
                  tabs: myTabs,
                  controller: _tabController,
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  //mapato section
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: width * paddingRatio),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dataFilter = false;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: !dataFilter
                                          ? Colors.deepPurple
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sort,
                                          color: !dataFilter
                                              ? Colors.white
                                              : Colors.black,
                                          size: 20),
                                      SizedBox(width: 6),
                                      Text("Yote",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: !dataFilter
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ],
                                  )),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () async {
                                await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Filter by Date'),
                                    content: TextFormField(
                                        onTap: () => _showSelectDate(context),
                                        keyboardType: TextInputType.none,
                                        controller:
                                            selectedBookingDateController,
                                        decoration: InputDecoration(
                                            label: Text("Choose Date"))),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                      color: dataFilter
                                          ? Colors.deepPurple
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          color: dataFilter
                                              ? Colors.white
                                              : Colors.black,
                                          size: 24),
                                    ],
                                  )),
                            ),
                            Spacer(),
                            Builder(builder: (context) {
                              return ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context, StateSetter setState) {
                                            return Container(
                                                padding: EdgeInsets.only(
                                                    top: 20,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                // height: height * 0.58,
                                                child: Form(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width),
                                                      child: Text(
                                                        "Pato Jipya",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .deepPurple),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width),
                                                      child: TextFormField(
                                                        controller:
                                                            chanzoController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Tafadhali jaza chanzo '
                                                                : null,
                                                        decoration: InputDecoration(
                                                            label:
                                                                Text("Chanzo"),
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width),
                                                      child: TextFormField(
                                                        controller:
                                                            amountController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Tafadhali jaza kiasi '
                                                                : null,
                                                        decoration: InputDecoration(
                                                            label:
                                                                Text("Kiasi"),
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal:
                                                                    paddingRatio *
                                                                        width),
                                                        child: DropdownSearch<
                                                            String>(
                                                          mode: Mode.MENU,
                                                          showSelectedItems:
                                                              true,
                                                          items: [
                                                            "Cash",
                                                            "Bank",
                                                            "Airtel Money",
                                                            "Mpesa",
                                                            "T-pesa",
                                                            "Tigo Pesa",
                                                            "Halopesa",
                                                            "Nyingine"
                                                          ],
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Category",
                                                          ),
                                                          // popupItemDisabled: (String s) => s.startsWith('I'),
                                                          onChanged: (data) {
                                                            setState(() {
                                                              categoryValue =
                                                                  data;
                                                            });
                                                          },
                                                          selectedItem: "Cash",
                                                        )),

                                                    SizedBox(height: 10),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    paddingRatio *
                                                                        width),
                                                        child: Text(
                                                          mapatoError,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    //register button
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width,
                                                              vertical: 20),
                                                      child: ElevatedButton(
                                                          onPressed:
                                                              !mapatoButtonClicked
                                                                  ? () {
                                                                      setState(
                                                                          () {
                                                                        mapatoButtonClicked =
                                                                            true;
                                                                      });
                                                                      DBHelper()
                                                                          .addItem(
                                                                              chanzoController
                                                                                  .text,
                                                                              amountController
                                                                                  .text,
                                                                              categoryValue,
                                                                              1)
                                                                          .then(
                                                                              (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          Navigator
                                                                              .pop(
                                                                            context,
                                                                          );
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            mapatoError =
                                                                                value;
                                                                            mapatoButtonClicked =
                                                                                false;
                                                                          });
                                                                          // ScaffoldMessenger.of(context)
                                                                          //     .showSnackBar(SnackBar(
                                                                          //         content: Text(value)));
                                                                        }
                                                                      }).onError((error,
                                                                              stackTrace) {
                                                                        setState(
                                                                            () {
                                                                          mapatoButtonClicked =
                                                                              false;
                                                                          mapatoError =
                                                                              error.toString();
                                                                        });
                                                                        // ScaffoldMessenger.of(context)
                                                                        //     .showSnackBar(SnackBar(
                                                                        //   content: Text(error.toString()),
                                                                        // ));
                                                                      });
                                                                    }
                                                                  : null,
                                                          child: Text(
                                                              "Ongeza Pato"),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            minimumSize: const Size
                                                                    .fromHeight(
                                                                50), // NEW
                                                            // enabled: isEditable,
                                                          )),
                                                    ),
                                                  ],
                                                )));
                                          });
                                        });
                                  },
                                  child: Text("Ongeza Mpya"));
                            })
                          ],
                        ),
                        Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: dataFilter
                                    ? db
                                        .collection("flow")
                                        .where("uid",
                                            isEqualTo:
                                                AuthenticationHelper().user.uid)
                                        .where("date",
                                            isEqualTo:
                                                selectedBookingDateController
                                                    .text)
                                        .where("type", isEqualTo: 1)
                                        .snapshots()
                                    : db
                                        .collection("flow")
                                        .where("uid",
                                            isEqualTo:
                                                AuthenticationHelper().user.uid)
                                        .where("type", isEqualTo: 1)
                                        .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    return Text("No data");
                                  }
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var item = snapshot.data!.docs[index];
                                        return GestureDetector(
                                            child: Card(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  Text(
                                                      item
                                                              .data()
                                                              .toString()
                                                              .contains('title')
                                                          ? item.get('title')
                                                          : '',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Spacer(),
                                                  AppPopupMenu(
                                                    menuItems: const [
                                                      // PopupMenuItem(
                                                      //   value: 2,
                                                      //   child: Text('Edit'),
                                                      // ),
                                                      PopupMenuItem(
                                                        value: 3,
                                                        child: Text('Delete'),
                                                      ),
                                                    ],
                                                    // initialValue: 2,
                                                    onSelected: (int value) {
                                                      // print("selected");
                                                      // print(item.id);
                                                      if (value == 1) {
                                                      } else if (value == 3) {
                                                        // print("here inside");
                                                        db
                                                            .collection("flow")
                                                            .doc(item.id)
                                                            .delete();
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .more_vert_outlined),
                                                  )
                                                ]),
                                                Text(
                                                    "Amount: TZS ${item.get('amount')}")
                                              ],
                                            ),
                                          ),
                                        ));
                                      });
                                }))
                      ],
                    ),
                  ),

                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: width * paddingRatio),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dataFilter2 = false;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: !dataFilter2
                                          ? Colors.deepPurple
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sort,
                                          color: !dataFilter2
                                              ? Colors.white
                                              : Colors.black,
                                          size: 20),
                                      SizedBox(width: 6),
                                      Text("Yote",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: !dataFilter2
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ],
                                  )),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () async {
                                await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Filter by Date'),
                                    content: TextFormField(
                                        onTap: () => _showSelectDate2(context),
                                        keyboardType: TextInputType.none,
                                        controller:
                                            selectedBookingDateController2,
                                        decoration: InputDecoration(
                                            label: Text("Choose Date"))),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                      color: dataFilter2
                                          ? Colors.deepPurple
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          color: dataFilter2
                                              ? Colors.white
                                              : Colors.black,
                                          size: 24),
                                    ],
                                  )),
                            ),
                            Spacer(),
                            Builder(builder: (context) {
                              return ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context, StateSetter setState) {
                                            return Container(
                                                padding: EdgeInsets.only(
                                                    top: 20,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                // height: height * 0.58,
                                                child: Form(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width),
                                                      child: Text(
                                                        "Matumizi Mapya",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .deepPurple),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width),
                                                      child: TextFormField(
                                                        controller:
                                                            sababuController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Tafadhali jaza Sababu '
                                                                : null,
                                                        decoration: InputDecoration(
                                                            label:
                                                                Text("Sababu"),
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width),
                                                      child: TextFormField(
                                                        controller:
                                                            amountController2,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Tafadhali jaza kiasi '
                                                                : null,
                                                        decoration: InputDecoration(
                                                            label:
                                                                Text("Kiasi"),
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal:
                                                                    paddingRatio *
                                                                        width),
                                                        child: DropdownSearch<
                                                            String>(
                                                          mode: Mode.MENU,
                                                          showSelectedItems:
                                                              true,
                                                          items: [
                                                            "Cash",
                                                            "Bank",
                                                            "Airtel Money",
                                                            "Mpesa",
                                                            "T-pesa",
                                                            "Tigo Pesa",
                                                            "Halopesa",
                                                            "Nyingine"
                                                          ],
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "Category",
                                                          ),
                                                          // popupItemDisabled: (String s) => s.startsWith('I'),
                                                          onChanged: (data) {
                                                            setState(() {
                                                              categoryValue2 =
                                                                  data;
                                                            });
                                                          },
                                                          selectedItem: "Cash",
                                                        )),

                                                    SizedBox(height: 10),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    paddingRatio *
                                                                        width),
                                                        child: Text(
                                                          mapatoError,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    //register button
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  paddingRatio *
                                                                      width,
                                                              vertical: 20),
                                                      child: ElevatedButton(
                                                          onPressed:
                                                              !mapatoButtonClicked2
                                                                  ? () {
                                                                      setState(
                                                                          () {
                                                                        mapatoButtonClicked2 =
                                                                            true;
                                                                      });
                                                                      DBHelper()
                                                                          .addItem(
                                                                              sababuController
                                                                                  .text,
                                                                              amountController2
                                                                                  .text,
                                                                              categoryValue2,
                                                                              2)
                                                                          .then(
                                                                              (value) {
                                                                        if (value ==
                                                                            null) {
                                                                          Navigator
                                                                              .pop(
                                                                            context,
                                                                          );
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            mapatoError2 =
                                                                                value;
                                                                            mapatoButtonClicked2 =
                                                                                false;
                                                                          });
                                                                          // ScaffoldMessenger.of(context)
                                                                          //     .showSnackBar(SnackBar(
                                                                          //         content: Text(value)));
                                                                        }
                                                                      }).onError((error,
                                                                              stackTrace) {
                                                                        setState(
                                                                            () {
                                                                          mapatoButtonClicked2 =
                                                                              false;
                                                                          mapatoError2 =
                                                                              error.toString();
                                                                        });
                                                                        // ScaffoldMessenger.of(context)
                                                                        //     .showSnackBar(SnackBar(
                                                                        //   content: Text(error.toString()),
                                                                        // ));
                                                                      });
                                                                    }
                                                                  : null,
                                                          child: Text("Ongeza"),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            minimumSize: const Size
                                                                    .fromHeight(
                                                                50), // NEW
                                                            // enabled: isEditable,
                                                          )),
                                                    ),
                                                  ],
                                                )));
                                          });
                                        });
                                  },
                                  child: Text("Ongeza Mpya"));
                            })
                          ],
                        ),
                        Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: dataFilter2
                                    ? db
                                        .collection("flow")
                                        .where("uid",
                                            isEqualTo:
                                                AuthenticationHelper().user.uid)
                                        .where("date",
                                            isEqualTo:
                                                selectedBookingDateController
                                                    .text)
                                        .where("type", isEqualTo: 2)
                                        .snapshots()
                                    : db
                                        .collection("flow")
                                        .where("uid",
                                            isEqualTo:
                                                AuthenticationHelper().user.uid)
                                        .where("type", isEqualTo: 2)
                                        .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    return Text("No data");
                                  }
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var item = snapshot.data!.docs[index];
                                        return GestureDetector(
                                            child: Card(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  Text(
                                                      item
                                                              .data()
                                                              .toString()
                                                              .contains('title')
                                                          ? item.get('title')
                                                          : '',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Spacer(),
                                                  AppPopupMenu(
                                                    menuItems: const [
                                                      // PopupMenuItem(
                                                      //   value: 2,
                                                      //   child: Text('Edit'),
                                                      // ),
                                                      PopupMenuItem(
                                                        value: 3,
                                                        child: Text('Delete'),
                                                      ),
                                                    ],
                                                    // initialValue: 2,
                                                    onSelected: (int value) {
                                                      // print("selected");
                                                      // print(item.id);
                                                      if (value == 1) {
                                                      } else if (value == 3) {
                                                        // print("here inside");
                                                        db
                                                            .collection("flow")
                                                            .doc(item.id)
                                                            .delete();
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .more_vert_outlined),
                                                  )
                                                ]),
                                                Text(
                                                    "Amount: TZS ${item.get('amount')}")
                                              ],
                                            ),
                                          ),
                                        ));
                                      });
                                }))
                      ],
                    ),
                  ),
                ]),
              ),
            ])));
  }

  Future<void> _showSelectDate(BuildContext context) async {
    var dateSelect = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2040));
    if (dateSelect != null) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      final selctedFormatedDate = dateFormat.format(dateSelect);
      setState(() {
        selectedBookingDateController.text = selctedFormatedDate;
      });
    }
    if (selectedBookingDateController.text != null) {
      setState(() {
        dataFilter = true;
      });
    }
  }

  Future<void> _showSelectDate2(BuildContext context) async {
    var dateSelect = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2040));
    if (dateSelect != null) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      final selctedFormatedDate2 = dateFormat.format(dateSelect);
      setState(() {
        selectedBookingDateController2.text = selctedFormatedDate2;
      });
    }
    if (selectedBookingDateController2.text != null) {
      setState(() {
        dataFilter2 = true;
      });
    }
  }
}
