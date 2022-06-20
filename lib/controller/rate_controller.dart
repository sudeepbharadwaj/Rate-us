import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'dart:math' as math;
// ignore: unnecessary_import
import 'package:flare_flutter/base/math/mat2d.dart';

class RateusController extends FlareController{
  // ignore: unused_field
  FlutterActorArtboard? _artboard;
  ActorAnimation? _rateanimation;

  double slidepercent =0.0;
  double currentslide =0.0;
  double smoothTime =5.0;


  void updatePercent (double val){
    slidepercent=val;

  }

  @override
  void initialize (FlutterActorArtboard artboard){
    if(artboard.name.compareTo('Artboard')==0){
      _artboard=artboard;
      _rateanimation=artboard.getAnimation("slide") as ActorAnimation;
    }
  }

  @override
  bool advance(FlutterActorArtboard artboard,double elapsed){
    if(artboard.name.compareTo('Artboard')==0){
      currentslide+=(slidepercent-currentslide)*
      math.min(1,elapsed*smoothTime);
      _rateanimation!.apply(currentslide*_rateanimation!.duration, artboard, 1);
    }
    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    // ignore: todo
    // TODO: implement setViewTransform
  }

}
