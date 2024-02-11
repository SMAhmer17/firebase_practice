
/* 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class insertOperation extends StatefulWidget {
  insertOperation({super.key});

  @override
  State<insertOperation> createState() => _insertOperationState();
   
}

class _insertOperationState extends State<insertOperation> {
 
  final insertFirestore = FirebaseFirestore.instance.collection('Users');

  // CollectionReference ref = FirebaseFirestore.instance.collection('')
    // TEXT CONTROLLER
 final inputController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert/Crud Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: inputController,
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            String id = DateTime.now().millisecondsSinceEpoch.toString();

            insertFirestore.doc(id).set({
              'id' : id,
              'title' : inputController.text.toString()
              
            }).then((value){
              
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Added')));
              Navigator.pop(context);
            }).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
            });

          }, child: Text('Add to db'))

          
        
        ],
      ),
    );
  }
}

*/