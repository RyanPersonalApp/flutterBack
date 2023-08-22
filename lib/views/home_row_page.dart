
import 'dart:convert';
import 'package:firstapp/views/components/ListViews/ListContainer/ListLoadingScreen.dart';

import "layout/default.dart";

 // remoteOrigin usage
import 'package:firstapp/server/home.dart';
import 'package:flutter/material.dart';
import '../helper/app_helper.dart';
import 'package:firstapp/views/components/ListViews/ListContainer/NormalListContainer.dart';
import 'package:firstapp/views/components/ListViews/WidgetProperty/NormalRows.dart';
class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<HomeListPage> createState()=>_HomeListPageState();
}
  class _HomeListPageState extends State<HomeListPage>
  {
    late List<dynamic> data;
    Widget cacheView=const Column();
    @override
    Widget build(BuildContext context){
        // AuthenticateMiddleware.init(context);
        // top 64 for center 
      return DefaultLayout(title:'Home',body:  Container(
        margin:const EdgeInsets.only(top:64.0),
        child: FutureBuilder(
              future:homeRequest(),
              builder: (context,AsyncSnapshot<dynamic>snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the network request
                  /*
                    最好直接調整高度就好 不要調整bottom 否則loading會被穿過去
                  */
                  return ListLoadingScreen(theList: cacheView);
          
              } else if (snapshot.hasError) {
                // If there was an error during the network request
                return Text('Error: ${snapshot.error}');
              } else {
      
              
              final data=jsonDecode(snapshot.data.body);
          
              
        
            
              cacheView=NormalListContainer(vertical:false,data: data,widgetFactory:NormalRow.new);
              return  cacheView;
        
              }//else end
               
              }
            ),
      ));

  }

}