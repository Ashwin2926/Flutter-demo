import 'package:fl_firebase/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        actions: [
          IconButton(
            onPressed: () async {
              bool userAdded = await usersViewModel.addUser();
              if (!userAdded) {
                return;
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
              onChanged: (val) async {
                usersViewModel.addingUser.name = val;
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (val) async {
                usersViewModel.addingUser.email = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}
