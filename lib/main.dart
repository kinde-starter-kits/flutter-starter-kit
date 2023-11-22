import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/encrypted_box.dart';
import 'package:kinde_flutter_sdk/kinde_flutter_sdk.dart';

import 'home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KindeFlutterSDK.initializeSDK(
      authDomain: "<your_kinde_domain>",
      authClientId: "<client_id>",
      loginRedirectUri: '<your_custom_scheme>://kinde_callback',
      logoutRedirectUri: '<your_custom_scheme>://kinde_logoutcallback',
      audience: '<audience>', //optional
      scopes: ["email","profile","offline","openid"] // optional
  );

  await EncryptedBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Kinde StarterKit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
