import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'package:intl/intl.dart';

class DBHelper {
  final db = FirebaseFirestore.instance;

  Future<dynamic> addItem(title, amount, method, type) async {
    await db.collection("flow").add({
      "title": title,
      "amount": amount,
      "type": type, // 1 is mapato 2 matumizi 3 kudai 4 kudaiwa
      "date": DateFormat('dd/MM/yyyy').format(DateTime.now()),
      "method": method,
      "status": "0",
      "uid": AuthenticationHelper().user.uid,
    });

    return null;
  }

  // Future<void> completeCheckout() async {
  //   QuerySnapshot lists = await db
  //       .collection("cart")
  //       .where("uid", isEqualTo: AuthenticationHelper().user.uid)
  //       .where("status", isEqualTo: "0")
  //       .get();

  //   print("lists");
  //   print(lists.docs[0]['price']);
  //   // var list =  lists.map((event) => event).toList();

  //   for (var element in lists.docs) {
  //     // print("element");
  //     await db.collection("cart").doc(element.id).update({"status": 1});
  //     // print(element);
  //   }
  // }
}
