import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_firebase/components/app_error.dart';
import 'package:fl_firebase/components/user_list_row.dart';
import 'package:fl_firebase/models/users_list_model.dart';
import 'package:fl_firebase/screens/add_user_screen.dart';
import 'package:fl_firebase/screens/signin_screen.dart';
import 'package:fl_firebase/utils/navigation_utils.dart';
import 'package:fl_firebase/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_loading.dart';

class HomeScreen extends StatelessWidget {
  String errorMessage = '';
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(actions: [
        ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            try {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              });
              errorMessage = '';
            } on FirebaseAuthException catch (error) {
              errorMessage = error.message!;
            }
          },
        ),
        IconButton(
          onPressed: () async {
            openAddUser(context);
          },
          icon: const Icon(
            Icons.add,
          ),
        ),
      ]),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text(errorMessage),
            ),
            _ui(usersViewModel),
          ],
        ),
      ),
    );
  }

  _ui(UsersViewModel usersViewModel) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = usersViewModel.userListModel[index];
          return UserListRow(
            userModel: userModel,
            onPressed: () async {
              usersViewModel.setSelectedUser(userModel);
              openUserDetails(context);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }
}
