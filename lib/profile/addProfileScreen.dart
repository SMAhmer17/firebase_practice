
import'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProfile extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? contact;
  final String? email;
  final String? country;
  const AddProfile({super.key, this.firstName, this.lastName, this.contact, this.email, this.country});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
 

  // form key

  final _formKey =GlobalKey<FormState>();


  // for inserting user
  final addData = FirebaseFirestore.instance.collection('User_Profile');

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final conatctController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();


  // Image Picker

  File? _image;

  // will allow us to get image
  final picker = ImagePicker();

  Future getImageFromGallery()async{

    final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    setState(() {
      
    if(pickedFile != null){
      _image = File(pickedFile.path);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image picked') , backgroundColor: Colors.red,));
    }
 }); 
   }

  // Firebase Storage
  
    final storage = FirebaseStorage.instance;

  // to store image in db

  final dbRef = FirebaseFirestore.instance.collection('UserP');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                 CircleAvatar(
                  radius: 80 ,
                  backgroundColor: _image!= null ? null :  Colors.red,
                  // backgroundColor:  Colors.red,
                  child: _image!= null ? ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.file(_image!.absolute , fit: BoxFit.cover, width: double.infinity ,height: double.infinity,)) 
                    : 
                    Icon(Icons.person , size : 80 , color: Colors.white, )
                    
                ),

                Positioned(
                  bottom:  2,
                  right: 2,
                  child: InkWell(
                    onTap: ()=> getImageFromGallery(),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.edit)),
                  )),
                  ],),
                
                const SizedBox(height: 20,),
                  Row( 
                    children: [
                                        // First Name
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: firstNameController,
                    // initialValue: widget.firstName,
                    decoration: const InputDecoration(
                      label: Text('First Name'),
                      border: OutlineInputBorder(
                        
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      hintText: 'Enter your first name'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter first name";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12,),
            
                  // Last Name
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: lastNameController,
                    // initialValue: widget.lastName,
                    decoration: const InputDecoration(
                      label: Text('Last Name'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      hintText: 'Enter your last name'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter last name";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
           
                    ],
                    
                  ),

                 const SizedBox(height: 12,),
                   

                  // Contact
                TextFormField(
                  controller: conatctController,
                  keyboardType: TextInputType.number,
                  // initialValue: widget.contact.toString(),
                  decoration: const InputDecoration(
                    label: Text('Contact Number'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    hintText: 'Enter your contact number'
                    
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter contact name";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12,),
            
                  // Email
                TextFormField(
                  controller: emailController,
                   keyboardType: TextInputType.emailAddress,
                  // initialValue: widget.email,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    hintText: 'Email Address'
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter valid email";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12,),
            
                  // Country
                TextFormField(
                  controller: countryController,
                  // initialValue: widget.country,
                  decoration: const InputDecoration(
                    label: Text('Country'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    hintText: 'Pakistan'
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter country name";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 30,),
            
                ElevatedButton(onPressed: ()async{
            
                    Reference ref = FirebaseStorage.instance.ref('/profileImage/' + '${DateTime.now().millisecondsSinceEpoch}');
                    UploadTask uploadTask = ref.putFile(_image!.absolute);
                    await Future.value(uploadTask).then((value){

                    }).onError((error, stackTrace){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                    });

                    var newUrl = await ref.getDownloadURL();
                    print(newUrl);

                    if(_formKey.currentState!.validate()){
                  
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  addData.doc(id).set({
                    'id' : id,
                    'first_name' : firstNameController.text.toString(),
                    'last_name' : lastNameController.text.toString(),
                    'contact' : conatctController.text.toString(),
                    'email' : emailController.text.toString(),
                    'country' : countryController.text.toString(),
                    'image_url'  : newUrl,
                  }).then((value){
                
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Added')));
                Navigator.pop(context);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
              });
                    }
                  }, child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal :  40.0 , vertical: 12),
                    child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18 )  ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,

                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}