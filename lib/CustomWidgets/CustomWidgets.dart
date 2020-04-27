import 'package:flutter/material.dart';
import 'package:flutter_playground/AppThemes/CustomBGs/customBGs.dart';

class AppBarWithSearch extends StatefulWidget implements PreferredSizeWidget {
  AppBarWithSearch({Key key}) : super(key: key);

  @override
  _AppBarWithSearchState createState() => _AppBarWithSearchState();

  @override
  Size get preferredSize {
    return Size.fromHeight(100);
  }
}

class _AppBarWithSearchState extends State<AppBarWithSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GradientBGs().getBG(GradientBGType.LightBlueGradient),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Left Column
          Expanded(            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text('Provinces')],
            ),
          ),
          // Right column
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[Text('Provinces')],
          ),
        ],
      ),
    );
  }
}
