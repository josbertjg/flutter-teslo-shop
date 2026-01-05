import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/domain/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else {
      throw UnimplementedError("Tipo ${value.runtimeType} no soportado");
    }
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    if (T is int) {
      return prefs.getInt(key) as T?;
    } else if (T is String) {
      return prefs.getString(key) as T?;
    } else if (T is bool) {
      return prefs.getBool(key) as T?;
    } else {
      throw UnimplementedError("Tipo $T no soportado");
    }
  }
}
