import 'package:Designs/screens.dart/dashboard.dart';
import 'package:flutter/material.dart';

import 'controller/form_controller.dart';
import 'model/form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desing App',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
       
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  List<DataForm> dataItems = List<DataForm>();
  
  @override
  void initState() {
    super.initState();

    FormController().getDataList().then((result) {
      setState(() {
        this.dataItems = result;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashBaordPage(items:  dataItems)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
              child: Center(
         
          child: Image(image: AssetImage("assets/load.gif")),
        ),
      );
  }
}