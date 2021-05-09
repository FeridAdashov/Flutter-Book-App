import 'package:book_project/Screens/Home/model/book.dart';
import 'package:book_project/Screens/Login/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference refUSERS =
      FirebaseFirestore.instance.collection('USERS');

  final CollectionReference refBOOKS =
      FirebaseFirestore.instance.collection('BOOKS');

  /// **************** USERS *****************
  Stream<QuerySnapshot> get usersSnapshot {
    return refUSERS.snapshots();
  }

  Stream<List<UserModel>> usersData() {
    return usersSnapshot
        .map((querySnapshot) => _userDataListFromSnapshot(querySnapshot));
  }

  Stream<List<String>> usersNameList(String type) {
    return usersSnapshot
        .map((snapshot) => _userNameListFromSnapshot(snapshot, type));
  }

  List<String> _userNameListFromSnapshot(QuerySnapshot snapshot, String type) {
    List<String> list = [];
    for (DocumentSnapshot ds in snapshot.docs) {
      var data = ds.data() as Map;
      list.add(data['name'].toString());
    }
    return list;
  }

  Future<String> userNameById(String id) async {
    return refUSERS.doc(id).get().then((value) => value['name']);
  }

  Future<UserModel> userDataByEmail(String? email) async {
    return refUSERS
        .doc(email)
        .get()
        .then((value) => _userDataFromSnapshot(value));
  }

  List<UserModel> _userDataListFromSnapshot(QuerySnapshot querySnapshot) {
    List<UserModel> list = [];
    for (DocumentSnapshot ds in querySnapshot.docs) {
      var data = ds.data();
      if (data != null) list.add(_userDataFromSnapshot(ds));
    }
    return list;
  }

  Future deleteUserData(String name) async {
    refUSERS.doc(name).delete();
  }

  Future setUserData(UserModel userModel) async {
    return await refUSERS.doc(userModel.email).set({
      'name': userModel.name,
      'password': userModel.password,
    });
  }

  //UserData from snapshot
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      name: data['name'] ?? '',
      email: snapshot.id,
      password: data['password'] ?? '',
    );
  }

  Future<bool> isUserExist(String user) async {
    final snapShot = await refUSERS.doc(user).get();
    return !(!snapShot.exists);
  }

  /// **************** BOOKS ***************

  Stream<QuerySnapshot> get booksSnapshot {
    return refBOOKS.snapshots();
  }

  Stream<List<Book>> booksList() {
    return usersSnapshot
        .map((querySnapshot) => _bookListFromSnapshot(querySnapshot));
  }

  List<Book> _bookListFromSnapshot(QuerySnapshot querySnapshot) {
    List<Book> list = [];
    for (DocumentSnapshot ds in querySnapshot.docs) {
      var data = ds.data();
      if (data != null) list.add(_bookDataFromSnapshot(ds));
    }
    return list;
  }

  Book _bookDataFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return Book(
        // name: data['name'] ?? '',
        // email: snapshot.id,
        // password: data['password'] ?? '',
        );
  }
}
