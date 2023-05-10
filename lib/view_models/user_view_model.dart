import 'package:fl_firebase/models/user_error.dart';
import 'package:fl_firebase/models/users_list_model.dart';
import 'package:fl_firebase/repo/api_status.dart';
import 'package:fl_firebase/repo/user_services.dart';
import 'package:flutter/widgets.dart';

class UsersViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userlistModel = [];
  UserError _userError = UserError(code: 121, message: " ");
  UserModel _selectedUser = UserModel();
  UserModel _addingUser = UserModel();

  bool get loading => _loading;
  List<UserModel> get userListModel => _userlistModel;
  UserError get userError => _userError;
  UserModel get selectedUser => _selectedUser;
  UserModel get addingUser => _addingUser;

  UsersViewModel() {
    getUsers();
  }
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) async {
    _userlistModel = userListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSelectedUser(UserModel userModel) {
    _selectedUser = userModel;
  }

  addUser() async {
    if (!isValid()) {
      return;
    }

    _userlistModel.add(addingUser);
    _addingUser = UserModel();
    notifyListeners();
    return true;
  }

  isValid() {
    if (addingUser.name.toString() == null ||
        addingUser.name.toString().isEmpty) {
      return false;
    }
    if (addingUser.email.toString() == null ||
        addingUser.email.toString().isEmpty) {
      return false;
    }
    return true;
  }

  getUsers() async {
    setLoading(true);
    var response = await Userservices.getUsers();
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
    }
  }
}
