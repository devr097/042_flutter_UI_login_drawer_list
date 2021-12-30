import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sgmbooking/screens/booking_list.dart';
import 'package:sgmbooking/service/next_screen.dart';
import 'package:sgmbooking/utils/icons.dart';
import 'package:sgmbooking/service/netService.dart';
import 'package:provider/provider.dart';
import 'package:sgmbooking/utils/snacbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  Icon lockIcon = LockIcon().lock;

  late String email;
  late String pass;

  bool offsecureText = true;
  bool signInStart = false;
  bool signInComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Theme.of(context).backgroundColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text('sign in',
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w900)),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintText: 'username',
                      labelText: 'Username'),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.length == 0) return "Email can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: offsecureText,
                  controller: passCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    //prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                        icon: lockIcon,
                        onPressed: () {
                          lockPressed();
                        }),
                  ),
                  validator: (String? value) {
                    if (value!.length == 0) return "Password can't be empty";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      pass = value;
                    });
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'forgot password?',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      //nextScreen(context, ForgotPasswordPage());
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //         builder: (context) => ForgotPasswordPage()));
                    },
                  ),
                ),
                Container(
                  height: 45,
                  child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Theme.of(context).primaryColor)
                              )
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Theme.of(context).primaryColor)),
                      child: signInStart == false
                          ? Text('sign in',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white))
                          : signInComplete == false
                          ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                          : Text('sign in successful!',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white)),
                      onPressed: () {
                        signInEmailPassword();
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("don't have an account?"),
                    TextButton(
                      child: Text('sign up',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        // nextScreenReplace(context, SignUpPage());
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
  signInEmailPassword() async {
    NetworkBloc sb = Provider.of<NetworkBloc>(context, listen: false);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        signInStart = true;
      });
      sb.signInwithEmailPassword(email, pass).then((_) async {
        print(["sb.hasError:",sb.hasError]);
        if (sb.hasError == false) {
          sb.guestSignout();
          sb.setSignIn();
          setState(() {
            signInComplete = true;
          });
          nextScreeniOSReplace(context, BookingList());
        } else {
          setState(() {
            signInStart = false;
          });
          openSnacbar(_scaffoldKey, sb.errorCode);
        }
      });
    }
  }
  void lockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        lockIcon = LockIcon().open;
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = LockIcon().lock;
      });
    }
  }
}
