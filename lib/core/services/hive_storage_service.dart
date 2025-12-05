import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lifepro_new/core/services/local_storage_service.dart';
import 'dart:convert';
import 'dart:typed_data';

class HiveLocalStorageService implements LocalStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _keyBox = 'encryption_keys';
  
  @override
  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Uint8List> _getEncryptionKey(String boxName) async {
    final keyString = await _secureStorage.read(key: '${_keyBox}_$boxName');
    if (keyString == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.write(
        key: '${_keyBox}_$boxName',
        value: base64UrlEncode(key),
      );
      return Uint8List.fromList(key);
    } else {
      return base64Url.decode(keyString);
    }
  }

  Future<Box> _openBox(String boxName) async {
    final key = await _getEncryptionKey(boxName);
    return await Hive.openBox(
      boxName,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  @override
  Future<void> save(String boxName, String key, dynamic value) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<dynamic> get(String boxName, String key) async {
    final box = await _openBox(boxName);
    return box.get(key);
  }

  @override
  Future<void> delete(String boxName, String key) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }
  
  @override
  Future<List<dynamic>> getAll(String boxName) async {
    final box = await _openBox(boxName);
    return box.values.toList();
  }
}
