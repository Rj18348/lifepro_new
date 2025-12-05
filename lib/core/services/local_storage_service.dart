
abstract class LocalStorageService {
  Future<void> init();
  Future<void> save(String boxName, String key, dynamic value);
  Future<dynamic> get(String boxName, String key);
  Future<void> delete(String boxName, String key);
  Future<List<dynamic>> getAll(String boxName);
}
