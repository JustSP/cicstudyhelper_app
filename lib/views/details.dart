import 'package:cicstudyhelper_app/CustomWidgets/CustomWidgets.dart';
import 'package:cicstudyhelper_app/model/cicdata.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PgProvinceDetails extends StatelessWidget {
  PgProvinceDetails({Key key, @required this.selectedItem}) : super(key: key);

  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CICData>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            elevation: Theme.of(context).brightness == Brightness.light ? 5 : 0,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.transparent,
            title: Text(model.provinces.provinces[this.selectedItem].name),
          ),
          body: ListView.builder(
              itemCount: model.provinces.provinces[this.selectedItem]
                  .institutions.institutions.length,
              itemExtent: 100,
              itemBuilder: (context, index) {
                return AppTiles().leftBorderedTile(model
                    .provinces
                    .provinces[this.selectedItem]
                    .institutions
                    .institutions[index].name,
                    model
                    .provinces
                    .provinces[this.selectedItem]
                    .institutions
                    .institutions[index].city,
                    model
                    .provinces
                    .provinces[this.selectedItem]
                    .institutions
                    .institutions[index].pgwpEligible?"Yes":"No");
              }),
        );
      },
    );
  }
}
