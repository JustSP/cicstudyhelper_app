import 'package:badges/badges.dart';
import 'package:cicstudyhelper_app/CustomWidgets/CustomWidgets.dart';
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
    return ScopedModelDescendant<CICData>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Provinces'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearch(cicData: model));
                },
              )
            ],
          ),
          body: ListView.builder(
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
                            builder: (context) => PgProvinceDetails(
                                  selectedItem: index,
                                )),
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
          ),
        );
      },
    );
  }
}

class DataSearch extends SearchDelegate {
  final CICData cicData;

  DataSearch({this.cicData});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<EducationalInstitution> _searchedInstitutes =
        new List<EducationalInstitution>();

    for (var province in cicData.provinces.provinces) {
      for (var institute in province.institutions.institutions) {
        if (institute.name.toLowerCase().contains(query.toLowerCase())) {
          _searchedInstitutes.add(institute);
        }
      }
    }

    if (_searchedInstitutes.length > 0) {
      cicData.addToRecentSearches(query);
    }

    return ListView.builder(
      itemCount: _searchedInstitutes.length,
      itemExtent: 100,
      itemBuilder: (context, index) {
        return AppTiles().leftBorderedTile(
            _searchedInstitutes[index].name,
            _searchedInstitutes[index].city,
            _searchedInstitutes[index].pgwpEligible ? "Yes" : "No");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: cicData.recentSearches.length,
      itemExtent: 30,
      itemBuilder: (context, index) {
        return AppTiles()
            .leftBorderedTile(cicData.recentSearches[index], "", "");
      },
    );
  }
}
