// ignore: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


final state =['Bad','OK','Good'];

var currentText=[
  Text(state[0],
  key:Key(state[0]),
  style: GoogleFonts.poppins(fontSize:19,fontWeight: FontWeight.w600,color: Colors.black),
  ),

  Text(state[1],
  key:Key(state[1]),
  style: GoogleFonts.poppins(fontSize:19,fontWeight: FontWeight.w600,color: Colors.black),
  ),
  Text(state[2],
  key:Key(state[2]),
  style: GoogleFonts.poppins(fontSize:19,fontWeight: FontWeight.w600,color: Colors.black),
  ),
];