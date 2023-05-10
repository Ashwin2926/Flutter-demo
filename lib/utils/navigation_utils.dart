import 'package:fl_firebase/screens/add_user_screen.dart';
import 'package:fl_firebase/screens/user_details_screen.dart';
import 'package:flutter/material.dart';

void openUserDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserDetailsScreen(),
    ),
  );
}

void openAddUser(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddUserScreen(),
    ),
  );
}
