import 'package:flutter/material.dart';
import 'package:firstapp/helper/app_helper.dart';
import "package:firstapp/constants/routes.dart";
import "dart:developer" as devtools show log;
enum SideMenuAction{
logout,
home,
homeColumn,
}
const logOut= Icon(
  Icons.logout,
  color: Colors.pink,
  size: 24.0,
  // semanticLabel: 'Text to announce in accessibility modes',
);
const home= Icon(
  Icons.home,
  color: Colors.pink,
  size: 24.0,
  // semanticLabel: 'Text to announce in accessibility modes',
);
typedef SideBarCallType = void Function();
class SideBarItemProperties{
  dynamic icon;
  String title;
  SideBarCallType? fn;
  static late State currentState;
  static late BuildContext currentContext;
  SideBarItemProperties({required this.icon,required this.title,this.fn});
  static void init(BuildContext context)
  {
    currentContext=context;
  }
}

Map<SideMenuAction,SideBarItemProperties> sideMenuAction=
{
    SideMenuAction.logout:SideBarItemProperties(icon:logOut,title:'LogOut',fn:(){
          if(SideBarItemProperties.currentContext.mounted)
          {
              StorageControl.authClear();
              HistoryRouter.goTo(SideBarItemProperties.currentContext,loginRoute);      
          }
          
    }),
    SideMenuAction.home:SideBarItemProperties(icon:home,title:'橫式',fn:(){
       if(SideBarItemProperties.currentContext.mounted)
       {
         final currentRouteName=ModalRoute.of(SideBarItemProperties.currentContext)?.settings.name??'';
         if(currentRouteName==homeRoute)
         {
              Navigator.of(SideBarItemProperties.currentContext).pop();
         }
          HistoryRouter.goTo(SideBarItemProperties.currentContext,homeRoute);    
       }
         
    }),
    SideMenuAction.homeColumn:SideBarItemProperties(icon:home,title:'直式',fn:(){
       if(SideBarItemProperties.currentContext.mounted)
       {
         final currentRouteName=ModalRoute.of(SideBarItemProperties.currentContext)?.settings.name??'';
         if(currentRouteName==columnhomeRoute)
         {
              Navigator.of(SideBarItemProperties.currentContext).pop();
         }
          HistoryRouter.goTo(SideBarItemProperties.currentContext,columnhomeRoute);    
       }
         
    }),
};
class SideBar extends StatefulWidget{
  const SideBar({super.key});
  @override
  State<SideBar> createState() =>_ContainerSideBar();
  
}
class _ContainerSideBar extends State<SideBar>{
  late List<StatelessWidget> _sideBarList;
  void initWithContext(BuildContext context,State state)
  {
    SideBarItemProperties.init(context);
    _sideBarList=sideMenuAction.entries.map((entry) {
            return ListTile(
              leading: entry.value.icon,
              title: Text(entry.value.title),
              onTap: entry.value.fn,
            );

      }).toList();// end given _menuItems
  }

  @override
 
  Widget build(BuildContext context)
  {
    initWithContext(context,this);
      return Drawer(
      width:240,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        children: <Widget>[
          
          DrawerHeader(
          decoration:const  BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/sidebar_img.jpg'))),
            child: Text(
              AuthenticateMiddleware.userName??'',
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
..._sideBarList

        ],
      ),
  );  
}// end build
}//end class



     