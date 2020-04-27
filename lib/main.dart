import 'dart:async';
import 'package:cicstudyhelper_app/model/cicdata.dart';
import 'package:cicstudyhelper_app/views/home.dart';
import 'package:cicstudyhelper_app/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/AppThemes/CustomThemes/customThemes.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

String _baseURL = "https://cicwebsitehelper-amit.azurewebsites.net";
String url = "$_baseURL/GetCICData";

Future<Provinces> _getCICData() async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    if (response.body != null) {
      dynamic parsedJson = json.decode(response.body);
      return Provinces.fromJson(parsedJson['Provinces']);
    } else {
      throw new Exception("Error fetching CIC data");
    }
  } else {
    throw new Exception("Error fetching CIC data");
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CICData _cicData = new CICData();

  @override
  void initState() {
    _getCICData().then((value) {
      _cicData.downloadCICData(value);
      //Navigator.of(context).popUntil((route) => route.isFirst);
      // Navigator.pop(context);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PgHome(provinces: null,)));
    });
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CICData>(
      model: _cicData,
      child: new MaterialApp(
        theme: CustomAppThemes().blueTheme(Brightness.dark, 500, 500),
        //initialRoute: '/',
        //routes: {'/': (context) => PgSplashScreen()},
        home: ScopedModelDescendant<CICData>(
          builder: (context, child, model){
            return model.showSplashScreen
            ? PgSplashScreen()
            : PgHome();
          },
        )
      ),
    );
  }
}
