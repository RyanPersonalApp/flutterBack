import 'package:flutter/material.dart';
import 'package:firstapp/helper/app_helper.dart';
import "package:firstapp/constants/routes.dart";
import 'package:firstapp/views/components/bars/menubar.dart';
import 'package:firstapp/views/components/bars/sidebar.dart';
import 'package:flutter/rendering.dart';
import 'package:firstapp/views/components/EditFancy/NormalEditFancy.dart';
const mainColor=Color.fromARGB(255, 131, 96, 96);
/*
  this layout will add every element into its child
*/



class DefaultLayout extends StatefulWidget {

  final String title;
  final dynamic body;
  const DefaultLayout({super.key,this.title="MyApp",required this.body});

  @override
  State<DefaultLayout> createState()=>_DefaultLayoutState();
}
class _DefaultLayoutState extends State<DefaultLayout>{

  @override
  Widget build(BuildContext context) {
      AuthenticateMiddleware.init(context,redirect: false);
     return Scaffold(
      resizeToAvoidBottomInset : false,
      
        drawer:const SideBar(),
        appBar:AppBar(
        title:Text(widget.title),
        actions:[
        PopupMenuButton<AuthMenuAction>(onSelected:(value){
          switch(value){
            case AuthMenuAction.logout:
              StorageControl.authClear();
              HistoryRouter.goTo(context,loginRoute);
          break;
            case AuthMenuAction.create:
              MessageBox.editDialog(context,const NormalEditFancy());
            break;
          default:
                HistoryRouter.goTo(context,homeRoute);
          break;
        }
    
        },itemBuilder:(context){
        return menuBars.menuItems;
          
        })
        ]
        ),
        // body:Scrollbar(
        //   child: PhysicalModel(
        //     color:mainColor,
        //     child: SingleChildScrollView(
        //       child: widget.body,
              
        //     ),
        //   ),
        // )// widget?
        body:PhysicalModel(
        color:mainColor,child:widget.body),
      );
  }


}
