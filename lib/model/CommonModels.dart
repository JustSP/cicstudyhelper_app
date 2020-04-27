import 'package:scoped_model/scoped_model.dart';

class NavigationModel extends Model {
  bool _showSplashScreen = true;

  bool get showSplashScreen => _showSplashScreen;

  void hideSplashScreen() {
    _showSplashScreen = false;
    notifyListeners();
  }
}
