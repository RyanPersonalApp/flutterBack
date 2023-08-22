/*
橫式列表 LoadingScreen
直式列表 LoadingScreen
*/
import 'package:flutter/material.dart';
import "package:firstapp/views/layout/default.dart" show  mainColor;

const loadColor=Color.fromARGB(255, 16, 193, 216);
class ListLoadingScreen extends StatelessWidget{
  final Widget theList;
  const ListLoadingScreen({super.key,required this.theList});
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
      // return Stack(
      //           children: [
      //             theList,
      //             Positioned(
      //         left: 0,
      //         right: 0,
      //         bottom: 0,
      //         child: Container(
      //           color: mainColor,
      //           height: 100,
      //           child: const Center(
      //             child: CircularProgressIndicator(color:loadColor), // Show loading indicator
      //           ),
      //         ),
      //       ),
      //       ]);
  }
}
