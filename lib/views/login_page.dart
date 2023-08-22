
// import 'dart:html';

import 'package:firstapp/views/home_column_page.dart';
import 'package:firstapp/views/register_page.dart';
import 'package:flutter/material.dart';
import '../helper/app_helper.dart';
import "dart:convert";

import "/constants/routes.dart";
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState()=>_LoginPageState();
}
  class _LoginPageState extends State<LoginPage>
  {
    
    String dialogContent="Something Went Wrong";
    late final TextEditingController _email;
    late final TextEditingController _password;
    

    bool alertMessage=false;
    bool loadBool=false;
    String? messageRed;
    @override
    void initState()
    {
        LoadConnection.url="$remoteOrigin/api/login";
        _email=TextEditingController();
        _password=TextEditingController();
        super.initState(); 
    }
    @override
    void dispose()
    {

      _email.dispose();
      _password.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context){
      
      return FutureBuilder(
        future:AuthenticateMiddleware.init(context),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
          {
          return const CircularProgressIndicator();
          }
          return Scaffold(
            appBar:AppBar(title:const Text('Login')),
            body:Column(
                      children: [
                      TextField(
                            controller:_email,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText:'Enter your email here',
                            ),
                      ),
                      TextField(
                            controller:_password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              hintText:'Enter your password here',
                            ),
                        ),
                      TextButton(
                      // login button
                      onPressed: ()async {
                      LoadConnection.json={

                        'email':_email.text,
                        'password':_password.text,
                      };
                      
                    

                        final res=LoadConnection.action().then((res){messageRed=null;return res;}).then((res)async{
                          if(res.statusCode!=200&&res.statusCode!=201)
                          {
                              messageRed=res.body;
                              return ;
                          }
                          else
                          {
                              return jsonDecode(res.body);
                          }

                      }).then((res)=>StorageControl.write('user',res)).whenComplete(()async {
                      
                        final bool auth=await AuthenticateMiddleware.init(context);
      
                        if(!auth&&context.mounted)
                        {
            
                          Navigator.of(context).pop();
                        }
               
                      }); 

                      await MessageBox.loading(context, res, false);
                      // 封裝過後的future 
                      // 先執行主程式
                  
                       //loading 和 future 都結束以後
                      // if(context.mounted)
                      // {
                      // // devtools.log('123');
                      //     await AuthenticateMiddleware.init(context);
                      // }
                        
                      if(context.mounted&&messageRed!=null)
                      {
                        MessageBox.red(context,text:messageRed);
                      }
                  
                   

            
                    

                      },// on pressed action end
                      child:const Text('Login') // child is the showing Text
                      ),
                      TextButton(
                      onPressed: (){
                        // HistoryRouter.goWidget(context,const RegisterPage());
                        HistoryRouter.goTo(context,registerRoute);
                      },
                      child:const Text('Not yet Register') // child is the showing Text
                      ),
                    ],
                  ),// widget?
          );
        }
      );

  }

}