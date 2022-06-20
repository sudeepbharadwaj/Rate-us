import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rateus/view/rate_scr.dart';


// ignore: camel_case_types
class homepage extends StatelessWidget {
  const homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,

    body:Center(
      child: 
      MaterialButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => const Rate_scr(),));
      },
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      height: 40,
      minWidth: 40,
      child: Text('Rate us',style: GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w600,color: Colors.white,),
      
      ),
    )
    )
    );
  }
}