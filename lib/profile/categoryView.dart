
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  
   Color selectedColor = Colors.red;
   
  @override
  Widget build(BuildContext context) {
    final height =  MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width;
    
    
    return Scaffold(
      appBar: AppBar(
        title:  Text('Category View'),
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children : [
                SizedBox(width: 3,),
                conatinerList(title: 'Hello' , Color: Colors.red),
                conatinerList(title: 'Hello' , Color: Colors.green),
                conatinerList(title: 'Hello' , Color: Colors.yellow),
                conatinerList(title: 'Hello' , Color: Colors.purple),
                conatinerList(title: 'Hello' , Color: Colors.cyan),
                conatinerList(title: 'Hello' , Color: Colors.orange),
                conatinerList(title: 'Hello' , Color: Colors.lightBlue),
          
                ]),),
                
                  SizedBox(height : 12),
                  Expanded(child: Container(color: selectedColor,),)
        ],
      ),
    );
  }

  InkWell conatinerList({required String title ,required Color Color}) {
    return InkWell(
      // splashColor: Colors.black,
      // focusColor: Colors.amber,
      borderRadius: BorderRadius.circular(100),
      // customBorder: CircleBorder(),
      onTap: (){
        setState(() {
          selectedColor = Color;
        });
      } 
      
       ,
      child: Padding(
      padding: const EdgeInsets.only( left : 5.0 , right: 5),
      child: Container(
        child: Center(child: Text(title)),
        height: 40,
        width: 100,
        decoration: BoxDecoration(
           color : Color,
          borderRadius: BorderRadius.circular(30)
        ),
         ),
                ),
    );
}
}