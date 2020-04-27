import 'package:flutter/material.dart';
import 'package:flutter_playground/AppThemes/CustomBGs/customBGs.dart';
import 'package:google_fonts/google_fonts.dart';

class PgSplashScreen extends StatelessWidget {
  PgSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: GradientBGs().getBG(GradientBGType.TwitchGradient),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'JustSP',
              style: GoogleFonts.balooBhaijaan(
                  color: Colors.purple[100],
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              'CIC Study Helper',
              style: GoogleFonts.muli(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 30),
            ),
            Divider(
              color: Colors.amber,
            ),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
            )
          ],
        ),
      ),
    ));
  }
}
