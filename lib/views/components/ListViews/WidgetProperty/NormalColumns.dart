
import 'package:flutter/material.dart';
import 'package:firstapp/constants/routes.dart';
class NormalColumn extends StatelessWidget{
  final String defaultNetWorkResolve="https://source.unsplash.com/1000x1000/?nature";
  final dynamic datafracture;
  const NormalColumn({super.key,this.datafracture});
  @override
  Widget build(BuildContext context) {
    final Widget url=Image.network((datafracture['url']==null)?defaultNetWorkResolve:"$remoteOrigin/storage/${datafracture['url']}");
    final Text name=Text(datafracture['name']);
    return Column(children: [name,url]);

  }
}
