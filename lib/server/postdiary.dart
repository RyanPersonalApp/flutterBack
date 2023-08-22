
import 'package:firstapp/helper/app_helper.dart';
import "dart:developer" as devtools show log;
Future<dynamic> postDiary(json)
{
  
  LoadConnection.url="https://template0410.goldball-design.com/api/v1/index/sanctum/create/diary";
  LoadConnection.json=json;
  return LoadConnection.action(method:'post');
}