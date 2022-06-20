// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rateus/controller/rate_controller.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

import '../model/flareTitle.dart';
import '../model/sliderpainter.dart';

enum SlideState {Bad,OK,Good}

// ignore: camel_case_types
class Rate_scr extends StatefulWidget {
  const Rate_scr({ Key? key }) : super(key: key);

  @override
  State<Rate_scr> createState() => _Rate_scrState();
}

// ignore: camel_case_types
class _Rate_scrState extends State<Rate_scr> with SingleTickerProviderStateMixin {

  RateusController? flareController;
   AnimationController? animationController;

   double sliderwidth=340;
   double sliderheight=50;

   double dragpercent=0.0;
    
  SlideState slidestate=SlideState.Bad;



void updateDragPosition(Offset offset){
  setState(() {
    
    dragpercent=(offset.dx/sliderwidth).clamp(0.0,1.0);
    flareController!.updatePercent(dragpercent);

    if(dragpercent>=0 && dragpercent<.3){
      slidestate=SlideState.Bad;
      animationController!.forward(from: 0.0);
    }
    else if(dragpercent>=0.3 && dragpercent<.7){
      slidestate=SlideState.OK;
      animationController!.stop();
    }
    else if(dragpercent>.7){
      slidestate=SlideState.Good;
    }
  });

}


Widget displayTitle(){
  switch (slidestate){
    case SlideState.Bad:
    return currentText[0];
    case SlideState.OK:
    return currentText[1];
    case SlideState.Good:
    return currentText[2];

  }

}


void onDragStart (BuildContext context,DragStartDetails details){
  RenderBox box=context.findRenderObject() as RenderBox;
  Offset localOffset=box.localToGlobal(details.globalPosition);
  updateDragPosition(localOffset);

}

void onDragUpdate (BuildContext context,DragUpdateDetails details){
  RenderBox box=context.findRenderObject() as RenderBox;
  Offset localoffset=box.localToGlobal(details.globalPosition);
  updateDragPosition(localoffset);
}


@override
void initState(){
  super.initState();
  flareController=RateusController();
  animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 750))..addListener(()=>setState(() {
    
  })
  );

}

shake(){
  double offset=math.sin(animationController!.value*math.pi*60.0);
  return vector.Vector3(offset*2,offset*2,0.0);
}


  @override
  Widget build(BuildContext context) {

    Color getcolor(){
      if (dragpercent <.3){
        return Colors.pink[100]!;

      }else if(dragpercent<.7){
        return Colors.green[100]!;
        
      }else if(dragpercent>.7){
        return Colors.green[300]!;
      }
      return Colors.pink[100]!;
    }


    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      color: getcolor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SafeArea(child:
        Column(
          children: [
            _buildAppBar(),
            _buildHeaderText(),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            _buildTitle(),
            SizedBox(height: MediaQuery.of(context).size.height*0.028,),
            _buildFlareActor(),
            SizedBox(height: MediaQuery.of(context).size.height*0.027,),
            _buildSlider(),
            SizedBox(height: MediaQuery.of(context).size.height*0.076,),
            _bottomBuild(),
          ],
        )
        ),
      ),
      
    );
  }


  _buildAppBar()=>Padding(padding:const EdgeInsets.only(top:20,left:28,right:15,bottom:20),

  child: Row(
     children: [
      IconButton(onPressed: (){

      }, 
      icon:const Icon(Icons.close,size:28)
      ),
      SizedBox(width: MediaQuery.of(context).size.width*0.12,),
      Text("Order Delivered", style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600,color: Colors.black.withOpacity(0.7)),)


     ],
  )
  
  );


  _buildHeaderText()=>Padding(padding: const EdgeInsets.only(left: 99.5,right: 50),
  child: Text('How Was Your Experience ?' ,style: GoogleFonts.poppins(fontSize:29.9,color: Colors.black.withOpacity(0.95),fontWeight: FontWeight.w700),),
  
  );

_buildTitle()=>AnimatedSwitcher(duration: const Duration(milliseconds: 200),
transitionBuilder: (child,anim){
  var slideAnim=Tween<Offset>(begin:const  Offset(-2,0),end: const Offset(0,0)).animate(anim);
  return ClipRRect(
    child: SlideTransition(position: slideAnim,child: child,),
  );
},
child: displayTitle(),

);


_buildFlareActor()=>Transform(transform:Matrix4.translation(shake()),
child: SizedBox(
  width: MediaQuery.of(context).size.width*0.88,
  height: MediaQuery.of(context).size.height*0.3,
  child: FlareActor(
    'assets/Rate.flr',
    artboard: 'Artboard',
    controller: flareController,
  ),
),

);

_buildSlider()=>GestureDetector(
  onHorizontalDragStart: (DragStartDetails details)=>onDragStart(context, details),
  onHorizontalDragUpdate: (DragUpdateDetails details)=>onDragUpdate(context, details),
  child: SizedBox(
    width: sliderwidth,
    height: sliderheight,
    child: CustomPaint(
      painter: SliderPainter(progress: dragpercent,),
    ),
  ),
);

_bottomBuild()=>SizedBox(
  height: MediaQuery.of(context).size.height*0.074,
  width: MediaQuery.of(context).size.width*0.79,
  child: RaisedButton(onPressed: (){},
  color: Colors.black,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0)
  ),
  child: Text('submit',style: GoogleFonts.poppins(fontSize:19,fontWeight: FontWeight.w600,color: Colors.white),),

  ),
);

}
