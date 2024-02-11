

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final id;
  final String firstName;
  final String lastName;
  final String contact;
  final String email;
  final String country;
  final String imageUrl;
  const EditProfile({super.key, required this.firstName, required this.lastName, required this.contact, required this.email, required this.country, this.id, required this.imageUrl});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
 

  // form key

  final _formKey =GlobalKey<FormState>();


  // for inserting user
  final addData = FirebaseFirestore.instance.collection('User_Profile');

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final conatctController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      imageUrl = widget.imageUrl;
      firstNameController.text  = widget.firstName;
      lastNameController.text = widget.lastName;
      conatctController.text = widget.contact;
      emailController.text = widget.email;
      countryController.text = widget.country;

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.clear();
    lastNameController.clear();
    conatctController.clear();
    countryController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                 CircleAvatar(
                  radius: 80 ,
                  backgroundColor: Colors.red,
                  // child: Image(image: image),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network(imageUrl , fit: BoxFit.cover, width: double.infinity ,height: double.infinity,)) ,
                ),
                const SizedBox(height: 12,),
                  Row( 
                    children: [
                                        // First Name
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: firstNameController,
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
            
                ElevatedButton(onPressed: (){
            
            
                    if(_formKey.currentState!.validate()){
                  
                  addData.doc(widget.id).set({
                    'id' : widget.id,
                    'first_name' : firstNameController.text.toString(),
                    'last_name' : lastNameController.text.toString(),
                    'contact' : conatctController.text.toString(),
                    'email' : emailController.text.toString(),
                    'country' : countryController.text.toString()
                  }).then((value){
                
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Added')));
                Navigator.pop(context);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
              });
                    }
                  }, child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal :  40.0 , vertical: 12),
                    child: Text('Update', style: TextStyle(color: Colors.white, fontSize: 18 )  ),
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