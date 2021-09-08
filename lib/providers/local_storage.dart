import 'package:money_tracker/contracts/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends ILocalStorage {
  LocalStorage(this._preferences);
  final SharedPreferences _preferences;

  @override
  Future<bool> clear() => _preferences.clear();

  @override
  bool? getBool(String key) => _preferences.getBool(key);

  @override
  double? getDouble(String key) => _preferences.getDouble(key);

  @override
  int? getInt(String key) => _preferences.getInt(key);

  @override
  Set<String> getKeys() => _preferences.getKeys();

  @override
  String? getString(String key) => _preferences.getString(key);

  @override
  List<String>? getStringList(String key) => _preferences.getStringList(key);

  @override
  Future<bool> remove(String key) => _preferences.remove(key);

  @override
  Future<bool> setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) =>
      _preferences.setDouble(key, value);

  @override
  Future<bool> setInt(String key, int value) => _preferences.setInt(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> values) =>
      _preferences.setStringList(key, values);
}