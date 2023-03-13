import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'firebase/fbController.dart';

class ContactList extends StatefulWidget {
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          centerTitle: true,

        ),
        body: FutureBuilder<DatabaseEvent>(
            future: FbControllerAddUser().getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else {
                final data = snapshot.data!.value;
                return ListView.builder(
                  itemCount: snapshot.data!.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(snapshot.data!.docs[index]['Name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const SizedBox(height: 3,),
                            Text('Phone : ${snapshot.data!.value[index]['phoneNumber']}',style: const TextStyle(fontSize: 14,color: Colors.redAccent),),
                            Text('Address : ${snapshot.data!.docs[index]['address']}',style: const TextStyle(fontSize: 14,color: Colors.green),)
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: ()async {
                            await QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'This contact will be deleted !',
                              onConfirmBtnTap: ()  {
                                  FbControllerAddUser().deleteUser(snapshot.data!.docs[index].id);
                                  Navigator.pop(context);
                              },
                              onCancelBtnTap: () {
                                Navigator.pop(context);
                              },

                              confirmBtnText: 'Delete',
                              confirmBtnColor: Colors.red,

                              title: ' Delete Contact',
                            );

                          },
                          icon: const Icon(Icons.delete,color: Colors.red,),
                        )

                    );
                  },
                );
              }
            }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.pushNamed(context, '/addContact');
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}