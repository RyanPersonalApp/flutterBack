
import 'package:firstapp/views/home_column_page.dart';
import 'package:flutter/material.dart';

import 'views/login_page.dart';
import 'views/register_page.dart';
import "constants/routes.dart";
import 'package:firstapp/views/home_row_page.dart';
// import 'dart:convert';
void main() {
  runApp(MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes:{
        loginRoute:(context)=>const LoginPage(),
        registerRoute:(context)=>const RegisterPage(),
        homeRoute:(context)=>const HomeListPage(),
        columnhomeRoute:(context)=>const HomePage(),
      }
  ));
  // StorageControl.run();
}

