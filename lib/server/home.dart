
import 'package:firstapp/helper/app_helper.dart';
import "dart:developer" as devtools show log;
Future<dynamic> homeRequest()
{
  
  LoadConnection.url="https://template0410.goldball-design.com/api/v1/index/sanctum/diary";
  return LoadConnection.action(method:'get');
}

Stream<dynamic> homeStreamRequest(int page)
{

  LoadConnectionStream.url="https://template0410.goldball-design.com/api/v1/index/FakeContent/testing";
  return LoadConnectionStream.pageAction(method:'get',endPage: page);
}