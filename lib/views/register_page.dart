import 'dart:convert';

import 'package:firstapp/views/login_page.dart';
import 'package:flutter/material.dart';
import '../helper/app_helper.dart';
import "/constants/routes.dart";
import "dart:developer" as devtools show log;
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState()=>_RegisterPageState();
}
  class _RegisterPageState extends State<RegisterPage>
  {

    String dialogContent="Something Went Wrong";
    late final TextEditingController _name;
    late final TextEditingController _email;
    late final TextEditingController _password;
    late final CircularProgressIndicator _loading=const CircularProgressIndicator();
      

    bool alertMessage=false;
    bool loadBool=false;
    
    @override
    void initState()
    {
        LoadConnection.url="$remoteOrigin/api/register";
        _name=TextEditingController();
        _email=TextEditingController();
        _password=TextEditingController();
        super.initState(); 
    }
    @override
    void dispose()
    {
      _name.dispose();
      _email.dispose();
      _password.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
          // AuthenticateMiddleware.init(context);
           String? messageRed;
      return Scaffold(
          resizeToAvoidBottomInset : false,
        appBar:AppBar(title:const Text('Register')),
        body:SingleChildScrollView(
          child: Column(
                        children: [
                            TextField(
                              controller:_name,
                              enableSuggestions: true,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText:'Type your Register Name here',
                              ),
                        ),
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
                        onPressed: ()async {
                        LoadConnection.json={
                          'name':_name.text,
                          'email':_email.text,
                          'password':_password.text,
                        };
              
                        final response=LoadConnection.action().then((res){
                            if(res.statusCode!=200&&res.statusCode!=201)
                            {
                               messageRed=res.body;
                                return ;
                            }
                            else
                            {
                                // devtools.log(res.body.toString());
                                _name.text="";
                                _email.text="";
                                _password.text="";
                                return jsonDecode(res.body);
                            }
                            //then end
        
                        }).then((res)=>StorageControl.write('user',res)).whenComplete(()async {
                          
                          final bool auth=await AuthenticateMiddleware.init(context);
            
                          if(!auth&&context.mounted)
                          {
              
                            Navigator.of(context).pop();
                          }
                  
                          });// response 封裝完畢 還未執行。
                            await MessageBox.loading(context, response, false);
                            if(context.mounted&&messageRed!=null)
                            {
                              MessageBox.red(context,text:messageRed);
                            }
              
                                
                        },
                        child:const Text('Register') // child is the showing Text
                        ),
                              TextButton(
                        onPressed: (){
                          // HistoryRouter.goWidget(context,const LoginPage());
                          HistoryRouter.goTo(context,loginRoute);
                        },
                        child:const Text('go to Login') // child is the showing Text
                        ),
                      ],
                    ),
        ),// widget?
      );

  }

}