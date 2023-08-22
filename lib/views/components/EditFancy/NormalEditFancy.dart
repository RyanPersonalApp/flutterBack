/*
橫式列表 LoadingScreen
直式列表 LoadingScreen
*/
import 'package:firstapp/constants/routes.dart';
import 'package:flutter/material.dart';
import "package:firstapp/views/layout/default.dart" show  mainColor;
import 'package:firstapp/server/postdiary.dart';
import 'package:firstapp/helper/app_helper.dart';
import "dart:developer" as devtools show log;
const loadColor=Color.fromARGB(255, 16, 193, 216);


class NormalEditFancy extends StatefulWidget{ 
  const NormalEditFancy({super.key});
  @override
  State<NormalEditFancy> createState()=>_NormalEditFancyState();
}
 class _NormalEditFancyState extends State<NormalEditFancy>
 {
  late final TextEditingController _name;
  late final TextEditingController _back_body;
  late Widget currentRenderWidget;
  late Widget _realView;
  late Map<String,dynamic> json;
  void action(json)async
  {
    currentRenderWidget=const CircularProgressIndicator();
    await postDiary(json);
    currentRenderWidget=_realView;

  }
   @override
  void initState()
  {

      _name=TextEditingController();
      _back_body=TextEditingController();
      super.initState(); 
  }
   void dispose()
    {

      _name.dispose();
       _back_body.dispose();
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _realView=SingleChildScrollView(
      child: SizedBox(width:200,height:300,child:Column(children: [
        TextField(
              controller:_name,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText:'編寫日記主旨',
              ),
        ),
      TextField(
              controller:_back_body,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText:'編寫您的日記內容',
              ),
        ),
       TextButton(
          onPressed: (){
            // HistoryRouter.goWidget(context,const RegisterPage());
           if(_name.text=='')
           {
               MessageBox.red(context,text: "主題不得為空");
               return;
           }
            json={'name':_name.text,'back_body':_back_body.text};
            action(json);
            Navigator.of(context).pop();
            // MessageBox.green(context,text: "成功送出");
            HistoryRouter.goTo(context, homeRoute);
          },
          child:const Text('送出') // child is the showing Text
          ),
      
      ],)),
    );
    currentRenderWidget=_realView;
    return currentRenderWidget;

  }
 }