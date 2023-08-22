import 'package:flutter/material.dart';
import "dart:developer" as devtools show log;
enum AuthMenuAction{
logout,
home,
create,
}
const Map<AuthMenuAction,String> authMenuAction=
{
    AuthMenuAction.logout:'LogOut',
    AuthMenuAction.home:'Home',
    AuthMenuAction.create:'Create',
};
class MenuBar {
  final Map<AuthMenuAction,String> menuBarsVariable;
  late final List<PopupMenuItem<AuthMenuAction>> menuItems;
   MenuBar(this.menuBarsVariable){
    menuItems=menuBarsVariable.entries.map((entry) {
      var key = entry.key;
      var value = entry.value;
      
      return PopupMenuItem<AuthMenuAction>(
        value: key,
        child: Text(value),
      );
    }).toList();// end given _menuItems
   }// end constructor
  void call(){
    // devtools.log('something is called, if you need you can use this line as a magic function __call in php');
    // _menuItems.add('');
  }
}//end class
final menuBars=MenuBar(authMenuAction);



     