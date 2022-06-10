import 'package:fedha_zangu/screens/home_nav_screen.dart';
import 'package:fedha_zangu/utils/auth.dart';
import 'package:fedha_zangu/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController emailControllerReg = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerReg = TextEditingController();

  String regError = "";

  bool regButtonClicked = false;
  bool loginButtonClicked = false;

  GlobalKey<FormState> loginForm = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Form(
          key: loginForm,
          child: ListView(children: [
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              child: Text("Fedha Zangu",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.deepPurple, fontWeight: FontWeight.w900)),
            ),
            Container(
                width: double.infinity,
                child: Text(
                  "Tunza Kumbukumbu sahihi ya fedha zako.",
                  textAlign: TextAlign.center,
                )),
            Center(
              child: SvgPicture.asset("assets/images/finance.svg",
                  width: width * 0.8, semanticsLabel: 'A red up arrow'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: paddingRatio * width),
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 10, horizontal: paddingRatio * width),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value!.isEmpty ? 'Tafadhali jaza email ' : null,
                controller: emailController,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (text) {},
                // onSubmitted: (text) {
                //   // viewModel.onlyProducts = true;
                //   // viewModel.onModelReady();
                // },
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                  label: Padding(
                    padding: EdgeInsets.only(top: 3, left: 12),
                    child: Text('Email'),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 10, horizontal: paddingRatio * width),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: passwordController,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (text) {},
                keyboardType: TextInputType.visiblePassword,
                validator: (value) =>
                    value!.isEmpty ? 'Tafadhali jaza password ' : null,
                // onSubmitted: (text) {
                //   // viewModel.onlyProducts = true;
                //   // viewModel.onModelReady();
                // },
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                  label: Padding(
                    padding: EdgeInsets.only(top: 3, left: 12),
                    child: Text('Password'),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingRatio * width),
              child: Row(
                children: const [
                  Spacer(),
                  InkWell(
                      child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingRatio * width),
              child: ElevatedButton(
                  onPressed: !loginButtonClicked
                      ? () {
                          if (loginForm.currentState!.validate()) {
                            setState(() {
                              loginButtonClicked = true;
                            });
                            AuthenticationHelper()
                                .signIn(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                              if (value == null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeNavScreen(
                                              index: 0,
                                            )));
                              } else {
                                // setState(() {
                                //   regError = value;
                                setState(() {
                                  loginButtonClicked = false;
                                });
                                // });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              }
                            }).onError((error, stackTrace) {
                              setState(() {
                                loginButtonClicked = false;
                                // regError = error.toString();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                              // ));
                            });
                          }
                        }
                      : null,
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                    // enabled: isEditable,
                  )),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              child: Builder(builder: (context) {
                return InkWell(
                    onTap: () {
                      regError = "";
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, StateSetter setState) {
                              return Container(
                                  padding: EdgeInsets.only(
                                      top: 20,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  // height: height * 0.58,
                                  child: Form(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: paddingRatio * width),
                                        child: Text(
                                          "Register",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.deepPurple),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: paddingRatio * width),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: TextFormField(
                                          controller: nameController,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 1,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          onChanged: (text) {},
                                          keyboardType: TextInputType.text,
                                          validator: (value) => value!.isEmpty
                                              ? 'Tafadhali jaza Jina kamili '
                                              : null,
                                          // onSubmitted: (text) {
                                          //   // viewModel.onlyProducts = true;
                                          //   // viewModel.onModelReady();
                                          // },
                                          cursorColor: Colors.grey,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            isCollapsed: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            border: InputBorder.none,
                                            label: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 3, left: 12),
                                              child: Text('Jina kamili'),
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                            // floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: paddingRatio * width),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: TextFormField(
                                          controller: emailControllerReg,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 1,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          onChanged: (text) {},
                                          keyboardType: TextInputType.text,
                                          validator: (value) => value!.isEmpty
                                              ? 'Tafadhali jaza Email '
                                              : null,
                                          // onSubmitted: (text) {
                                          //   // viewModel.onlyProducts = true;
                                          //   // viewModel.onModelReady();
                                          // },
                                          cursorColor: Colors.grey,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.email),
                                            isCollapsed: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            border: InputBorder.none,
                                            label: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 3, left: 12),
                                              child: Text('Email'),
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                            // floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: paddingRatio * width),
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: TextFormField(
                                          controller: passwordControllerReg,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 1,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          onChanged: (text) {},
                                          keyboardType: TextInputType.number,
                                          validator: (value) => value!.isEmpty
                                              ? 'Tafadhali jaza Password '
                                              : null,
                                          // onSubmitted: (text) {
                                          //   // viewModel.onlyProducts = true;
                                          //   // viewModel.onModelReady();
                                          // },
                                          cursorColor: Colors.grey,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.key),
                                            isCollapsed: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            border: InputBorder.none,
                                            label: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 3, left: 12),
                                              child: Text('Password'),
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                            // floatingLabelBehavior: FloatingLabelBehavior.never,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: paddingRatio * width),
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                                child: Container(
                                                    width: width -
                                                        paddingRatio * width -
                                                        40,
                                                    child: RichText(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                          text:
                                                              "By registering you agree to our ",
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade700),
                                                          children: const [
                                                            TextSpan(
                                                                text:
                                                                    "Terms & Conditions ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .deepPurple)),
                                                            TextSpan(
                                                              text: "and ",
                                                            ),
                                                            TextSpan(
                                                                text:
                                                                    "Privacy policy.",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .deepPurple))
                                                          ]),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: paddingRatio * width),
                                          child: Text(
                                            regError,
                                            style: TextStyle(color: Colors.red),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      //register button
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: paddingRatio * width,
                                            vertical: 20),
                                        child: ElevatedButton(
                                            onPressed: !regButtonClicked
                                                ? () {
                                                    setState(() {
                                                      regButtonClicked = true;
                                                    });
                                                    AuthenticationHelper()
                                                        .signUp(
                                                            email:
                                                                emailControllerReg
                                                                    .text,
                                                            name: nameController
                                                                .text,
                                                            password:
                                                                passwordControllerReg
                                                                    .text)
                                                        .then((value) {
                                                      if (value == null) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeNavScreen(
                                                                        index:
                                                                            0)));
                                                      } else {
                                                        setState(() {
                                                          regError = value;
                                                          regButtonClicked =
                                                              false;
                                                        });
                                                        // ScaffoldMessenger.of(context)
                                                        //     .showSnackBar(SnackBar(
                                                        //         content: Text(value)));
                                                      }
                                                    }).onError((error,
                                                            stackTrace) {
                                                      setState(() {
                                                        regButtonClicked =
                                                            false;
                                                        regError =
                                                            error.toString();
                                                      });
                                                      // ScaffoldMessenger.of(context)
                                                      //     .showSnackBar(SnackBar(
                                                      //   content: Text(error.toString()),
                                                      // ));
                                                    });
                                                  }
                                                : null,
                                            child: Text("Register"),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(
                                                      50), // NEW
                                              // enabled: isEditable,
                                            )),
                                      ),
                                    ],
                                  )));
                            });
                          });
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Not Registered? ",
                          style: TextStyle(color: Colors.grey.shade700),
                          children: [
                            TextSpan(
                                text: "Register Here.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple))
                          ]),
                    ));
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
