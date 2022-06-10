import 'package:fedha_zangu/screens/bajeti_screen.dart';
import 'package:fedha_zangu/screens/home_nav_screen.dart';
import 'package:fedha_zangu/utils/auth.dart';
import 'package:fedha_zangu/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BajetiDetails extends StatefulWidget {
  final item;
  BajetiDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<BajetiDetails> createState() => _BajetiDetailsState();
}

class _BajetiDetailsState extends State<BajetiDetails> {
  @override
  Widget build(BuildContext context) {
    var budget_texts = widget.item.get('items');
    var budget_numbers = widget.item.get('amounts');

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("New Budget")),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: width * paddingRatio * 0.5),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            Text(
              "Vilivyomo ndani ya budget",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: budget_numbers.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(budget_texts[index]),
                              Text(budget_numbers[index]),
                            ],
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
                    );
                  })),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              "Jumla: TZS ${getSum(budget_numbers)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }

  int getSum(numbers) {
    int total = 0;

    for (var item in numbers) {
      total += int.parse(item);
    }
    return total;
  }
}
