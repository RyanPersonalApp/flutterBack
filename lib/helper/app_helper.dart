
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "dart:developer" as devtools show log;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "/constants/routes.dart";
// class Status{
//   static late  BuildContext currentContext;
//   static late State currentState;
//   static void init(BuildContext context,State state)
//   {
//     if(context.mounted)
//     {
//       currentContext=context;
//       currentState=state;
//     }
//   }
// }
class LoadingScreen extends StatelessWidget {
 
  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height:600.0,
      child:  Scaffold(
        body: Center(
          
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
class LoadMajorScreen extends StatefulWidget {
  // const LoadingScreen({required this.action,super.key});
  final Future<dynamic> action;
  final bool rollback;
  const LoadMajorScreen({required this.action,required this.rollback,super.key});
  @override
  LoadFutureState createState() => LoadFutureState();
}

class LoadFutureState extends State<LoadMajorScreen> {
  @override
  Widget build(BuildContext context) {
    //devtools.log(widget._action.toString())
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: FutureBuilder<dynamic>(
        future: widget.action.whenComplete((){
          if(widget.rollback)
          {
            Navigator.of(context).pop();
          }
        }),
        builder: (context, snapshot) {
        
          return const LoadingScreen();
        },
      ),
    );
  }
}
class LoadConnectionStream{
static const String text="Loading ....";
  static String? url;
  static Map<String,dynamic>? json;
  static late dynamic result; 
  static Stream<dynamic> pageAction({Duration interval=const Duration(milliseconds: 1500),String method='get',int endPage=1})async*
  {
    LoadConnection.url=url;
    while(endPage>0)
    {
      final response=await LoadConnection.action(method: method);
      await Future.delayed(interval);
      yield response;    
      endPage--;
    }
  }
  static Stream<dynamic> action({Duration interval=const Duration(milliseconds: 5000),String method='get'})async*
  {
  // from Offical doc in dart
  /*
    I don't think it is a good approach cause too many request is generated
  */
    LoadConnection.url=url;
    while(true)
    {
      final response=await LoadConnection.action(method: method);
      await Future.delayed(interval);
      yield result=response;

    }
    // 級聯運算符，可以在statement之後插入下一個statement 而無需使用在使用暫借的變量
    /*
      var request=await client.postUrl(Uri.parse(url as String))
      request.headers.contentType=ContentType.json
      request.write(jsonEncode)
    */
  }
}
class LoadConnection{
  static const String text="Loading ....";
  static String? url;
  static Map<String,dynamic>? json;
  static Map<String,String> header={'Accept':'application/json'};
  static Future<dynamic> action({BuildContext? context,String method='post'})async
  {
  //如果想要debug節流效果 可以把底下的打開
  // devtools.log(method);
  // devtools.log(url.toString());
  if(AuthenticateMiddleware.check)
  {
      // LoadConnection.header={'Authorization':'Bearer $userToken','Accept':'application/json'};
      
      final user=await StorageControl.read('user').then((res)=>(res==null)?res:jsonDecode(res)['user']);
      final token=user['rememberToken']??'';
      
      header={...header,"Authorization":'Bearer $token'};
      // 假設如果 有token header 自動幫忙補上
  }
    if(url!=null)
    {
        if(method=='post')
        {
          final res=http.post(Uri.parse(url as String),body:json,headers:header);
          // if(context!=null)
          // {
          //       await HistoryRouter.goWidget(context, LoadMajorScreen(action:res,rollback:false));
          // } 
          return res;
        }
        else if(method=='get')
        {
          final res=http.get(Uri.parse(url as String),headers:header);
          // if(context!=null)
          // {
          //       await HistoryRouter.goWidget(context, LoadMajorScreen(action:res,rollback:false));
          // } 
                // devtools.log(res.body.toString());
          return res;
    
        }
        
    }
    return Future(() => null);
  }

}

class MessageBox{
 // 
  static const String defaultTitle="message";
  static const String defaultText="something went wrong";
  static  bool load=false;
  
  static Future red(BuildContext context,{String? text,String? title})
  {
    // do not call buildcontext synchorizely so I use async to load it
    text??=defaultText;
    title??=defaultTitle;
    return showDialog(context:context,builder:(_)=>AlertDialog(iconColor:const Color.fromARGB(255, 212, 11, 11),title:Text(title as String),content:Text(text as String)));
  }
  static Future green(BuildContext context,{String? text,String? title})
  {

    text??=defaultText;
    title??=defaultTitle;
    return showDialog(context:context,builder:(_)=>AlertDialog(iconColor:const Color.fromARGB(255, 18, 202, 116),title:Text(title as String),content:Text(text as String)));

  }
  static Future editDialog(BuildContext context, Widget content)
  {
    const String title="編寫日記";
    return showDialog(context:context,builder:(_)=>AlertDialog(title:const Text(title),content:content));
  }
  static Future loading(BuildContext context,Future action,bool rollback)
  {
    return HistoryRouter.goWidget(context, LoadMajorScreen(action:action,rollback:rollback));
  }
  // static Future loading(BuildContext context,Future theAction) // 為了程式統一性，如果在外部想要使用 await 語法，所以才返還一個空的future
  // {
  //   return theAction;
  //   // return Navigator.push(context, MaterialPageRoute(builder: (_)=>const  LoadingScreen()));
   
  // }
}
class HistoryRouter{
  static Future goWidget(BuildContext context,Widget secondRoute)
  {
    // 告訴她哪個context 你打算換掉
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => secondRoute),
      );
  }
  static Future? goTo(BuildContext context,String goToRouteName)
  {
      final currentRouteName=ModalRoute.of(context)?.settings.name??'';
      if(currentRouteName!=goToRouteName)
      {
           return Navigator.of(context).pushNamedAndRemoveUntil(goToRouteName, (_) => false);
      }
      return null;

      // _ 參數用不到
  }
}
class StorageControl{
    static const storage=FlutterSecureStorage();
    static Future read(String key)
    {
      return storage.read(key:key).then((res)=>(res=='null')?null:res);
      // for json encode  you should return an array of empty string

  //fast snippet(可以使用以下快速的程式碼片段)(#read):
      // StorageControl.read('user').then((res){
      //                 devtools.log(res);
      //               })
    }
    static Future write(String key,dynamic mixedValue)
    {
    //fast snippet(可以使用以下快速的程式碼片段)(#Write & read):
  // StorageControl.write('user',res).whenComplete(() => StorageControl.read('user').then((res){
  //                     devtools.log(res);
  //                   }));
      try{
          return storage.write(key: key, value: jsonEncode(mixedValue));
      }
      catch(e)
      {
          return Future(() => false);
      }
  
    }
    static Future clear()
    {
     return storage.deleteAll();
    }
    static Future authClear()
    {
      return storage.delete(key:'user');
    }
}

class AuthenticateMiddleware
{
  // this is originally want to be design as a subclass of abstract class BuildContext Class
  // but BuildContext has 21 overrides function to implements 
  // it is obviously not a good idea to do so
  // cause I want to get the current context
  // but right now I think its okay to get it as static class
  static late  String? userName;
  static late  dynamic user;
  static   bool check=false;
  static int rateSeconds=600;
  static bool startApp=false;
  static DateTime checkPoint=DateTime.now();
  // 從run time 開始記錄時間點
  //每十分鐘 向遠端伺服器請求一次到底是否有驗證
  // redirect 變量 是強制切換至 主頁 因此 只要有redirect 就必須驗證遠端的token變量
  static Future<bool> init(BuildContext context,{bool redirect=true})async
  {
    
      // 假設 checkPoint 還沒到
      // 先自己在StorageControl裡面看就是了 不用再請求遠端了
      // 也不用尋求正確性，反正10分鐘就會再跟遠端請求一次
      
      if(checkPoint.add(Duration(seconds: rateSeconds)).compareTo(DateTime.now())==1&&startApp&&!redirect)
      {
      // 靜態變量實際上不用寫 類名在前面，這裡凸顯清楚寫的
  // devtools.log('blocked rate limiter');
     
       AuthenticateMiddleware.check=await StorageControl.read('user')
      .then((res)=>(res==null)?res:jsonDecode(res)['user'])// 為了規避錯誤寫的，否則null 進去jsondecode會出問題
      .then((res)async{
        if(res==null)
        {
          return false;        
        }

          return true;
      });//end future
        if(!AuthenticateMiddleware.check)
        {
          if(context.mounted)
          {
            HistoryRouter.goTo(context,loginRoute);
          }

        }
        else
        {
          if(context.mounted&&redirect==true)
          {
              HistoryRouter.goTo(context,homeRoute);
          }
        
        }// end check
        return Future(() => AuthenticateMiddleware.check);
      } // end compare check point
      startApp=true;
       checkPoint=DateTime.now();
      return StorageControl.read('user')
      .then((res)=>(res==null)?res:jsonDecode(res)['user']) // I don't think remote user should be design 
      .then((res)async{
          if(res==null)
          {
    
              // _to=loginRoute;
              if(context.mounted)
              {
            
                  AuthenticateMiddleware.userName=null;
                    AuthenticateMiddleware.check=false;
                HistoryRouter.goTo(context,loginRoute);
              }
 
              return false;
          }
          else
          {

              final userToken=res['rememberToken']??'';
              // devtools.log(userToken);

              LoadConnection.url="$remoteOrigin/api/user";
              LoadConnection.header={'Authorization':'Bearer $userToken','Accept':'application/json'};
              int status=0;
              final response=await LoadConnection.action(method:'get').then((res){status=res.statusCode;return jsonDecode(res.body);});
                       
              if(status!=200)
              {
             
 
                if(context.mounted)
                {
                    // devtools.log(status.toString());
  
                  AuthenticateMiddleware.userName=null;
                    AuthenticateMiddleware.check=false;
                  HistoryRouter.goTo(context,loginRoute);
                }
                return false;
              }

     
                if(context.mounted)
                {
                  AuthenticateMiddleware.user=response;
                
                  AuthenticateMiddleware.userName=response['name'];
                AuthenticateMiddleware.check=true;
                  if(redirect==true)
                  {
                      HistoryRouter.goTo(context,homeRoute);
                  }
              
                }
                  // _to=homeRoute;
          return true;
      
      
              // devtools.log(AuthenticateMiddleware.user.toString());
              //    LoadConnection.json={

              //       'email':_email.text,
              //       'password':_password.text,
              //     };
              // LoadConnection.header={
              // 'Authorization':
              // };
              // devtools.log(res);          
          }
      })
      .catchError((_){
        // devtools.log(_.toString());
        // _to=loginRoute;
        if(context.mounted)
        {
   
          AuthenticateMiddleware.userName=null;
          AuthenticateMiddleware.check=false;
          HistoryRouter.goTo(context,loginRoute);
        }
        return false;
      });
     
     
  }

}