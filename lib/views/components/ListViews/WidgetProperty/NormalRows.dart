
// import 'dart:convert';
// import "dart:developer" as devtools show log;

// import 'package:firstapp/constants/routes.dart';
// import 'package:firstapp/server/home.dart';
// import 'package:flutter/material.dart';
// import 'package:firstapp/helper/app_helper.dart';
import 'package:firstapp/helper/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/constants/routes.dart';
class NormalRow extends StatelessWidget{
  final String defaultNetWorkResolve="https://source.unsplash.com/1000x1000/?nature";
  final dynamic datafracture;
  final double padding;
  // final Color borderColor=const Color.fromARGB(255, 235, 3, 3);
  const NormalRow({super.key,this.datafracture,this.padding=50});
  @override
  /*
  snippet
  */
  // 方法一:BorderRadius 打圓角
//   ClipRRect(
//     borderRadius: BorderRadius.circular(8.0),
//     child: Image.network(
//         subject['images']['large'],
//         height: 150.0,
//         width: 100.0,
//     ),
// )
// 方法二: rounded(#畫像圓餅)
// CircleAvatar(
//   radius: 48, // Image radius
//   backgroundImage: NetworkImage('imageUrl'),
// )
  Widget build(BuildContext context) {
    // final Widget url=Image.network((datafracture['url']==null)?defaultNetWorkResolve:"$remoteOrigin/storage/${datafracture['url']}");
    final ImageProvider url=NetworkImage((datafracture['url']==null)?defaultNetWorkResolve:"$remoteOrigin/storage/${datafracture['url']}");
      final roundedUrl=GestureDetector(
        onTap: (){
          HistoryRouter.goTo(context, columnhomeRoute);
        },
        child: CircleAvatar(
        radius: 96, // Image radius
        backgroundImage: url,
        
          ),
      );
    // 更加細微的操作可以看這篇
    //https://stackoverflow.com/questions/51513429/how-to-do-rounded-corners-image-in-flutter
    final Text name=Text(datafracture['name']);
    final dynamic singleRow=Expanded(child:Column(children:[name,roundedUrl]));
    return Row(children:[singleRow, SizedBox(width:padding)]);
  }
}


// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState()=>_HomePageState();
// }
//   class _HomePageState extends State<HomePage>
//   {
//     late ScrollController controller;
//     String dialogContent="Something Went Wrong";
//     late List<dynamic> data;
//     late List<dynamic> currentRenderData;
//     Widget cacheView=const Column();

//     int currentRenderNumber=3;
//     // late final CircularProgressIndicator _loading=const CircularProgressIndicator();
    

//     bool alertMessage=false;
//     bool loadBool=false;
//      void _scrollListener() {

//       //虛擬視圖最底下則為0 越往上數字越大
//       // 此是指 如若離最底下視圖已經低於500 
//       // 則渲染新的內容
//       if (controller.position.extentAfter <100) {
//         setState(() {
//           currentRenderNumber+=3;
//           currentRenderNumber=(currentRenderNumber>data.length)?data.length:currentRenderNumber;
    
     
//           // currentRenderData.addAll(data.sublist(previousRenderNumber,currentRenderNumber));
      
    
 
//         });
//       }
//     }
//     @override
//     void initState()
//     {
//           super.initState(); 
//           controller = ScrollController()..addListener(_scrollListener);

  
//     }
//     @override
//     void dispose()
//     {
//        super.dispose();
//      controller.removeListener(_scrollListener);
   
//     }
//     @override
//     Widget build(BuildContext context){
//         AuthenticateMiddleware.init(context,null);
//       return DefaultLayout(title:'Home',body:  FutureBuilder(
//             future:homeRequest(),
//             builder: (context,AsyncSnapshot<dynamic>snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//               // While waiting for the network request
//                 /*
//                   最好直接調整高度就好 不要調整bottom 否則loading會被穿過去
//                 */
//               return Stack(
//                 children: [
//                   cacheView,
//                   Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 color: mainColor,
//                 height: 100,
//                 child: const Center(
//                   child: CircularProgressIndicator(color:Color.fromARGB(255, 16, 193, 216)), // Show loading indicator
//                 ),
//               ),
//             ),

              
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               // If there was an error during the network request
//               return Text('Error: ${snapshot.error}');
//             } else {

            
//             final response=jsonDecode(snapshot.data.body);
//             // devtools.log(response.toString());
            
//             data=response.map((single)=>{...single,'url':(single['url']==null)?'https://source.unsplash.com/1000x1000/?nature':"$remoteOrigin/storage/${single['url']}"}).toList();
         
//             currentRenderData=data.sublist(0,currentRenderNumber);
  
      
        
//             cacheView=ListContainer(blocks: currentRenderData,stateScrollController:controller);
//             return  cacheView;
//               // devtools.log(responseToBlocks.runtimeType.toString());
//               // return const ImageShowList(url: 'https://source.unsplash.com/1000x1000/?nature', name: 'some Text');
//               // If the network request completed successfully
//                   // return ListContainer(blocks: blocks)
//             }//else end
             
//             }
//           ));

//   }

// }