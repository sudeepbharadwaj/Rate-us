import 'package:flutter/material.dart';
import 'package:rateus/view/homepage.dart';


void main () {
  
runApp(const Rateus());
}

class Rateus extends StatelessWidget {
  const Rateus({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rate US',
      theme: ThemeData(
        primaryColor:Colors.white,
            scaffoldBackgroundColor:Colors.white
      ),
      home: const homepage(),
      
    );
  }
}

