import 'package:flutter/material.dart';
import "dart:developer" as devtools show log;
class NormalListContainer extends StatefulWidget {
  final List data; // 全部的資料
  final int loadNumber; // 紀錄每次載幾筆資料
  final double itemExtent;
  final double padding;
  final Function widgetFactory;
  final bool vertical;
  const NormalListContainer({this.vertical=true,this.loadNumber=3,this.itemExtent=300,this.padding=24.0,required this.widgetFactory,required this.data,super.key});
  
  @override
  State<NormalListContainer> createState() =>_NormalListContainerState();
}

class _NormalListContainerState extends State<NormalListContainer> {
  late ScrollController controller;
  late int currentRenderNumber;
  late int perLoad;
  void _scrollListener() {

      //虛擬視圖最底下則為0 越往上數字越大
      // 此是指 如若離最底下視圖已經低於500 
      // 則渲染新的內容

      if (controller.position.extentAfter <100) {

        setState(() {
          currentRenderNumber+=perLoad;
          currentRenderNumber=(currentRenderNumber>widget.data.length)?widget.data.length:currentRenderNumber;
     
          // currentRenderData.addAll(data.sublist(previousRenderNumber,currentRenderNumber));
      
    
 
        });
      }
    }
  @override
  void initState() {

      super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    currentRenderNumber=(widget.data.length<widget.loadNumber)?widget.data.length:widget.loadNumber;
    perLoad=widget.loadNumber;

  }
    @override
    void dispose()
    {
       super.dispose();
     controller.removeListener(_scrollListener);
   
    }
  @override
  Widget build(BuildContext context) {
    // devtools.log(currentRenderNumber.toString());
    return  ListView.builder(
    	scrollDirection: (widget.vertical)?Axis.vertical:Axis.horizontal,
      itemExtent: widget.itemExtent,
      shrinkWrap: true,
       padding:(widget.vertical)?EdgeInsets.all(widget.padding):EdgeInsets.symmetric(vertical:0.0,horizontal:widget.padding),
      itemCount:currentRenderNumber,
      controller:controller,
      itemBuilder:(context,int index){

        return widget.widgetFactory(datafracture:widget.data[index]);
        // return widget.widgetFactory(fracture);
    
      },
      );

  }
}