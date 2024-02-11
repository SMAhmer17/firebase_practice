import 'package:firebasemastery/profile/addProfileScreen.dart';
import 'package:firebasemastery/profile/editProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  
    // for FETCHINF user
  final fetchData = FirebaseFirestore.instance.collection('User_Profile').snapshots();


    // for update and delete
  
  final CollectionReference refProfile = FirebaseFirestore.instance.collection('User_Profile');


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home View'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fetchData, 
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
              
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Center(child : Text('Some Error Occured'));
              }else{
                return Expanded(
                  child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context , index){
                    return ListTile(
                      iconColor: Colors.black,
                      style: ListTileStyle.drawer,
                      onTap: (){
                        showDialog(context: context, builder:(BuildContext context){
                          return Dialog(
                            backgroundColor: Colors.amber,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: height * .6,
                                maxWidth: width * .8
                              ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal : 20.0 , vertical: 2),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                    backgroundColor: Colors.red,
                                  child  : ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(snapshot.data!.docs[index]['image_url'].toString() , fit: BoxFit.cover, width: double.infinity ,height: double.infinity,))  
                                    ),
                                    
                                TextFormField(
                                  initialValue: '${snapshot.data!.docs[index]['first_name'].toString()}  ${snapshot.data!.docs[index]['last_name'].toString()} '  ,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    label: Text('Name'),
                                  ),),
                                  const SizedBox(height: 12,),
                                  TextFormField(
                                  initialValue: '${snapshot.data!.docs[index]['country'].toString()}'  ,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    label: Text('Country'),
                                  ),),
                                  const SizedBox(height: 12,),
                                  TextFormField(
                                  initialValue: '${snapshot.data!.docs[index]['email'].toString()}'  ,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    label: Text('Email'),
                                  ),),
                                  const SizedBox(height: 12,),
                                  TextFormField(
                                  initialValue: '${snapshot.data!.docs[index]['contact'].toString()}'  ,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    label: Text('Contact'),
                                  ),),
                                  const SizedBox(height: 12,),
                                  ],
                                ),
                              ),
                            ),
                               ),
                          );
                        });
                      
                        
                      },

            
                      leading:
                      CircleAvatar(
                        radius:30,
                        // radius: 50,
                        child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image.network(snapshot.data!.docs[index]['image_url'].toString() , fit: BoxFit.cover, width: double.infinity ,height: double.infinity,)),
                      )  
                                    ,
                      title: Text(snapshot.data!.docs[index]['last_name'].toString() , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),),
                      subtitle:Text(snapshot.data!.docs[index]['contact'].toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (builder) => [
                            PopupMenuItem(child:ListTile(leading : Icon(Icons.edit , color: Colors.blue,) , title: Text('Edit'),)   , onTap: () { 

                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile(
                                id : snapshot.data!.docs[index]['id'],
                                firstName: snapshot.data!.docs[index]['first_name'].toString(), 
                                lastName: snapshot.data!.docs[index]['last_name'].toString(), 
                                contact: snapshot.data!.docs[index]['contact'].toString(), 
                                email: snapshot.data!.docs[index]['email'].toString(), 
                                country: snapshot.data!.docs[index]['country'].toString(),
                                imageUrl: snapshot.data!.docs[index]['image_url'].toString(),
                                )));

                                // refProfile.doc(snapshot.data!.docs[index]['id']).update({
                                //     'last_name' : 'Ali'
                                //  });


                            },),
                            PopupMenuItem(child:ListTile(leading : Icon(Icons.delete , color: Colors.red,) , title: Text('Delete'),)   , onTap: () { 
                                             refProfile.doc(snapshot.data!.docs[index]['id']).delete();


                            },),
                      ]),
                    
                    );
                  
                                }),
                );
              }
              
            })
                   
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProfile()));
      }),
      );
  }


}