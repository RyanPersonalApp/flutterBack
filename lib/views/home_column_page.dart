
import 'dart:convert';
import "layout/default.dart";
import "dart:developer" as devtools show log;
import 'package:firstapp/views/components/ListViews/ListContainer/ListLoadingScreen.dart';

import 'package:firstapp/views/components/ListViews/ListContainer/NormalListContainer.dart';
import 'package:firstapp/views/components/ListViews/WidgetProperty/NormalColumns.dart';
import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/server/home.dart';
import 'package:flutter/material.dart';
import '../helper/app_helper.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState()=>_HomePageState();
}
  class _HomePageState extends State<HomePage>
  {
    late ScrollController controller;
    late List<dynamic> data;
    Widget cacheView=const Column();
    // late final CircularProgressIndicator _loading=const CircularProgressIndicator();
    
    @override
    Widget build(BuildContext context){
        // AuthenticateMiddleware.init(context);
      return DefaultLayout(title:'Home',body:  FutureBuilder(
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
            // devtools.log(response.toString());
            
    
  
      
        
            cacheView=NormalListContainer(padding:48.0,data: data,widgetFactory:NormalColumn.new);
            return  cacheView;
              // devtools.log(responseToBlocks.runtimeType.toString());
              // return const ImageShowList(url: 'https://source.unsplash.com/1000x1000/?nature', name: 'some Text');
              // If the network request completed successfully
                  // return ListContainer(blocks: blocks)
            }//else end
             
            }
          ));

  }

}