import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/userModel.dart';

class FbControllerAddUser {

  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  int id = 0;
    Future<void> addUser({required userModel user}) {
      return ref.set(user.toJson()).then((value) =>id++);
    }


    Future<DataSnapshot> getData() async {
    return  ref.get();
          }

    Future<void> deleteUser(String id) async{
    await  ref.child(id).remove();
    }



  }
