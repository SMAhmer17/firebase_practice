import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class categoryFirebase extends StatefulWidget {
  const categoryFirebase({super.key});

  @override
  State<categoryFirebase> createState() => _categoryFirebaseState();
}

class _categoryFirebaseState extends State<categoryFirebase> {


  // FOR FETCHING
    final fetchData = FirebaseFirestore.instance.collection('animal_categories').snapshots();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Category'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(child: ElevatedButton(onPressed: main, child: Text('Download'))),
          StreamBuilder<QuerySnapshot>(
          stream: fetchData , 
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Center(child : Text('Some Error Occured'));
              }else{
           return Expanded(
             child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context , index){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: height * .06,
                        width: width * .3,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 218, 249, 219),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                        radius: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(snapshot.data!.docs[index]['image_url'].toString() , fit:  BoxFit.cover, height: double.infinity, width: double.infinity,),),
                      ),
                      const SizedBox(width: 8,),
                      Text(snapshot.data!.docs[index]['title'].toString() , style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),   
                      ),
                    ),
                  ),
                ],
              );
                // Text(snapshot.data!.docs[index]['title'].toString()),
                // child: Text(snapshot.data!.docs[index]['image_url'].toString()),
              
             }),
           ); 
           }
          }
          ),
          Expanded(
            flex: 8,
            child:Container(color: Colors.amber,)) 
          
          
          ],
      ) ,

    );
  }

  Future<void> main() async {
  // Replace these with the actual paths of your three images
  List<String> imagePaths = ['adopt_3.png', 'cat_1.png', 'cat_product.png'];

  for (String imagePath in imagePaths) {
    String? downloadURL = await getDownloadURL(imagePath);

    if (downloadURL != null) {
      print('Download URL for $imagePath: $downloadURL');
    } else {
      print('Failed to get download URL for $imagePath');
    }
  }
}

Future<String?> getDownloadURL(String imagePath) async {
  try {
    Reference storageReference = FirebaseStorage.instance.ref('/Animal Images/').child(imagePath);
    return await storageReference.getDownloadURL();
  } catch (e) {
    print('Error getting download URL for $imagePath: $e');
    return null;
    }
  }
}