import 'package:scoped_model/scoped_model.dart';

class CICData extends Model {
  Provinces _provinces;
  bool _showSplashScreen = true;
  List<String> _recentSearches = new List<String>();

  Provinces get provinces => _provinces;
  bool get showSplashScreen => _showSplashScreen;
  List<String> get recentSearches => _recentSearches;

  void downloadCICData(Provinces provinces) {
    this._provinces = provinces;
    hideSplashScreen();
    notifyListeners();
  }

  void hideSplashScreen() {
    _showSplashScreen = false;
  }

  void addToRecentSearches (String value){
    _recentSearches.add(value);
    notifyListeners();
  }
}

class Provinces {
  final List<CanadianProvince> provinces;

  Provinces({this.provinces});

  factory Provinces.fromJson(List<dynamic> provincesJson) {
    List<CanadianProvince> provinces = new List<CanadianProvince>();

    provinces = provincesJson.map((i) => CanadianProvince.fromJson(i)).toList();

    return new Provinces(provinces: provinces);
  }
}

class CanadianProvince {
  final String name;
  final String code;
  final Institutions institutions;

  CanadianProvince({this.name, this.code, this.institutions});

  factory CanadianProvince.fromJson(Map<String, dynamic> provinceJson) {
    return CanadianProvince(
        name: provinceJson['Name'],
        code: provinceJson['Code'],
        institutions: Institutions.fromJson(provinceJson['Institutions']));
  }
}

class Institutions {
  final List<EducationalInstitution> institutions;

  Institutions({this.institutions});

  factory Institutions.fromJson(List<dynamic> parsedJson) {
    List<EducationalInstitution> institutions =
        new List<EducationalInstitution>();

    institutions =
        parsedJson.map((i) => EducationalInstitution.fromJson(i)).toList();

    return new Institutions(institutions: institutions);
  }
}

class EducationalInstitution {
  final String name;
  final String city;
  final String campuses;
  final String detailsURL;
  final bool pgwpEligible;
  final bool allCourses;

  EducationalInstitution(
      {this.name,
      this.city,
      this.campuses,
      this.detailsURL,
      this.pgwpEligible,
      this.allCourses});

  factory EducationalInstitution.fromJson(Map<String, dynamic> json) {
    return EducationalInstitution(
      name: json['Name'],
      city: json['City'],
      campuses: json['Campuses'],
      detailsURL: json['DetailsURL'],
      pgwpEligible: json['PGWPEligible'] as bool,
      allCourses: json['AllCourses'] as bool,
    );
  }
}
