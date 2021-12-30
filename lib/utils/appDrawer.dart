import 'package:flutter/material.dart';
import 'package:sgmbooking/screens/blank_page.dart';
import 'package:sgmbooking/screens/booking_list.dart';
import 'package:sgmbooking/screens/login.dart';
import 'package:sgmbooking/service/next_screen.dart';

Widget appDrawer(BuildContext context){
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Booking List'),
          onTap: () {
            Navigator.pop(context);
            nextScreeniOSReplace(context, BookingList());
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Blank Page'),
          onTap: () {
            Navigator.pop(context);
            nextScreeniOSReplace(context, BlankPage());
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BlankPage()));
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}