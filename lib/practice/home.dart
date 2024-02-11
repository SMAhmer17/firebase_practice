
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebasemastery/insertOperation.dart';
// import 'package:flutter/material.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {

//       // For fetching data using snapshot
//   final fetchFirestore = FirebaseFirestore.instance.collection('Users').snapshots();

//   // for update and delete

//   CollectionReference ref = FirebaseFirestore.instance.collection('Users');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Mastery'),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//               // Fetching
//           StreamBuilder<QuerySnapshot>(
//           stream:fetchFirestore , 
//           builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return CircularProgressIndicator();
//             }
//             else if(snapshot.hasError){
//               return Center(child: Text('Some Error occured'));
//             }
//             return Expanded(child: ListView.builder(
//               itemCount: snapshot.data!.docs.length, 
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: (){

//                         //  Update
//                     /* 
//                     ref.doc((snapshot.data!.docs[index]['id'].toString())).update({
//                       'title' : 'Asif taj'
//                     }).then((value) => null).onError((error, stackTrace) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
//                     });
                    

//                                            // Delete
//                     // ref.doc((snapshot.data!.docs[index]['id'].toString())).delete();
//                   },
//                   title: Text(snapshot.data!.docs[index]['title'].toString()),
//                   subtitle: Text(snapshot.data!.docs[index]['id'].toString()) ,

//                   trailing: Row(children: [],),
//                   // trailing: Row(
//                   //   children: [
//                   //     IconButton(onPressed: (){
//                   //         ref.doc((snapshot.data!.docs[index]['id'].toString())).delete().
//                   //         then((value){
//                   //            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted Successfully' , selectionColor: Colors.red,)));
//                   //         }).onError((error, stackTrace) {
//                   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
//                   //   });;
                        


//                   //     }, icon: Icon(Icons.update)),
//                   //     IconButton(onPressed: (){}, icon: Icon(Icons.delete))
//                   //   ],
//                   // ),
                  
//                 );

//               },
//               ));
//           })
            
//         ],    
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => insertOperation()));
//       }),
    
//     );
//   }
// }

