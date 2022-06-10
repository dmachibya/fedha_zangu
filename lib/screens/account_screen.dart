import 'package:fedha_zangu/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fedha_zangu/utils/styles.dart';

import '../utils/auth.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (AuthenticationHelper().user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    return SafeArea(
        child: Container(
      padding:
          EdgeInsets.symmetric(vertical: 20, horizontal: paddingRatio * width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Account"),
          Row(children: [
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
                  return Container(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.get('name'),
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        Text(snapshot.data!.get('email')),
                      ],
                    ),
                  );
                })
          ]),
          Divider(),
          InkWell(
            onTap: () {
              AuthenticationHelper().signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Row(children: const [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 28,
                  )
                ]),
              ),
            ),
          ),
          Divider(),
          Text("About This App",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black)),
          Text(
              "This mobile Application is currently under test phase, and is being developed (This version being an overnight project). It is provided only for testing and educational purposes."),
          SizedBox(
            height: 12,
          ),
          Text("About App Developer",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black)),
          Text(
              "David S. Machibya is the developer of this application. He is web developer and mobile apps developer. He is ready for any inquiries, feel most welcomed."),
          SizedBox(height: 12),
          Text("Contacts",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black)),
          Text("Phone: +255 752 759 016"),
          Text("Email: dmachibya@gmail.com"),
          Text("Website: www.zetuapps.com"),
          SizedBox(height: 12),
          Text("Version",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black)),
          Text("0.1.0"),
        ],
      ),
    ));
  }
}
