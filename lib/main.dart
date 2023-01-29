import 'package:flutter/material.dart';
import 'get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_assignment/screens/list_persons_screen.dart';


void main() async{
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(

      designSize: const Size(411.50, 876.75),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Assignment',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const ListPersons(),
        );
      },
    );
  }
}


