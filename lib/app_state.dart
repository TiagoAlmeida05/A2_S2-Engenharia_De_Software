import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _FavouritesState = prefs
              .getStringList('ff_FavouritesState')
              ?.map((path) => path.ref)
              .toList() ??
          _FavouritesState;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
  }

  bool _VisibilidadeNewPassword = true;
  bool get VisibilidadeNewPassword => _VisibilidadeNewPassword;
  set VisibilidadeNewPassword(bool value) {
    _VisibilidadeNewPassword = value;
  }

  List<DocumentReference> _FavouritesState = [];
  List<DocumentReference> get FavouritesState => _FavouritesState;
  set FavouritesState(List<DocumentReference> value) {
    _FavouritesState = value;
    prefs.setStringList(
        'ff_FavouritesState', value.map((x) => x.path).toList());
  }

  void addToFavouritesState(DocumentReference value) {
    FavouritesState.add(value);
    prefs.setStringList(
        'ff_FavouritesState', _FavouritesState.map((x) => x.path).toList());
  }

  void removeFromFavouritesState(DocumentReference value) {
    FavouritesState.remove(value);
    prefs.setStringList(
        'ff_FavouritesState', _FavouritesState.map((x) => x.path).toList());
  }

  void removeAtIndexFromFavouritesState(int index) {
    FavouritesState.removeAt(index);
    prefs.setStringList(
        'ff_FavouritesState', _FavouritesState.map((x) => x.path).toList());
  }

  void updateFavouritesStateAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    FavouritesState[index] = updateFn(_FavouritesState[index]);
    prefs.setStringList(
        'ff_FavouritesState', _FavouritesState.map((x) => x.path).toList());
  }

  void insertAtIndexInFavouritesState(int index, DocumentReference value) {
    FavouritesState.insert(index, value);
    prefs.setStringList(
        'ff_FavouritesState', _FavouritesState.map((x) => x.path).toList());
  }

  String _newPassword = '';
  String get newPassword => _newPassword;
  set newPassword(String value) {
    _newPassword = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
