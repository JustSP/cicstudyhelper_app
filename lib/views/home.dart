import 'package:badges/badges.dart';
import 'package:cicstudyhelper_app/model/cicdata.dart';
import 'package:cicstudyhelper_app/views/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';

class PgHome extends StatefulWidget {
  PgHome({Key key}) : super(key: key);

  @override
  _PgHomeState createState() => _PgHomeState();
}

class _PgHomeState extends State<PgHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provinces'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: ScopedModelDescendant<CICData>(
        builder: (context, child, model) {
          return ListView.builder(
            itemCount: model.provinces.provinces.length,
            itemExtent: 100,
            itemBuilder: (context, index) {
              return Card(
                  elevation: 5,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: new InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PgProvinceDetails(selectedItem: index,)),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 25,
                          left: 10,
                          child: Text(
                            model.provinces.provinces[index].name,
                            style: GoogleFonts.balooBhaijaan(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Badge(
                            shape: BadgeShape.square,
                            alignment: Alignment.center,
                            position: BadgePosition.topRight(),
                            badgeContent: Text(
                              model.provinces.provinces[index].institutions
                                  .institutions.length
                                  .toString(),
                              style: GoogleFonts.balooBhaijaan(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildSuggestions');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('buildSuggestions');
  }
}
