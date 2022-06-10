import 'package:fedha_zangu/screens/bajeti_screen.dart';
import 'package:fedha_zangu/screens/home_nav_screen.dart';
import 'package:fedha_zangu/utils/auth.dart';
import 'package:fedha_zangu/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BajetiMpya extends StatefulWidget {
  BajetiMpya({Key? key}) : super(key: key);

  @override
  State<BajetiMpya> createState() => _BajetiMpyaState();
}

class _BajetiMpyaState extends State<BajetiMpya> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dhumuniController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final db = FirebaseFirestore.instance;

  bool submitButtonClicked = false;

  var budget_texts = [];
  var budget_numbers = [];

  @override
  Widget build(BuildContext context) {
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
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'Tafadhali jaza kiasi ' : null,
              decoration: InputDecoration(
                  label: Text("Jina la Bajeti"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Vilivyomo ndani budget",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: dhumuniController,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        value!.isEmpty ? 'Tafadhali jaza dhumuni ' : null,
                    decoration: InputDecoration(
                        label: Text("Dhumuni / Kitu"),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Tafadhali jaza gharama ' : null,
                    decoration: InputDecoration(
                        label: Text("Gharama"), border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // var numbers = budget_numbers;
                        // numbers.a
                        budget_numbers.add(amountController.text);
                        budget_texts.add(dhumuniController.text);

                        amountController.text = "";
                        dhumuniController.text = "";
                      });
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            SizedBox(
              height: 20,
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
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      budget_numbers.removeAt(index);
                                      budget_texts.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.delete)),
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
            ElevatedButton(
                onPressed: !submitButtonClicked
                    ? () {
                        setState(() {
                          submitButtonClicked = true;
                        });
                        db.collection("bajeti").add({
                          "uid": AuthenticationHelper().user.uid,
                          "name": nameController.text,
                          'items': budget_texts,
                          "amounts": budget_numbers
                        }).then((value) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeNavScreen(index: 0)))
                            });
                      }
                    : null,
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), // NEW
                  // enabled: isEditable,
                )),
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
