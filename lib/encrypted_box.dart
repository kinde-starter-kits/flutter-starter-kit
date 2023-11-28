import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kinde_flutter_sdk/kinde_flutter_sdk.dart';

class EncryptedBox {
  static const String _encryptionKey = 'myEncryptionKey';
  static const String _boxName = 'myBox';

  static EncryptedBox get _instance => EncryptedBox._privateConstructor();

  EncryptedBox._privateConstructor();

  static EncryptedBox get instance {
    return _instance;
  }

  Box get _box => Hive.box(_boxName);

  static Future<void> init() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var containsEncryptionKey =
        await secureStorage.containsKey(key: _encryptionKey);
    List<int> secureKey;
    if (!containsEncryptionKey) {
      secureKey = Hive.generateSecureKey();
      await secureStorage.write(
          key: _encryptionKey, value: base64UrlEncode(secureKey));
    } else {
      final base64 = await secureStorage.read(key: _encryptionKey);
      secureKey = base64Url.decode(base64!);
    }
    await Hive.openBox(_boxName, encryptionCipher: HiveAesCipher(secureKey));
  }

  Future<String?> returnAccessToken() async {
    var token = _box.get('token', defaultValue: '');
    if (token == '') {
      return await getNewToken();
    } else if (token != null) {
      bool hasExpired = JwtDecoder.isExpired(token);
      if (hasExpired) {
        return await getNewToken();
      }
      return token;
    } else {
      return getNewToken();
    }
  }

  Future<String?> getNewToken() async {
    String? token = await KindeFlutterSDK.instance.getToken();
    if (token == null) return null; // Redirect user to the login page
    await _box.put('token', token);
    return token;
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
