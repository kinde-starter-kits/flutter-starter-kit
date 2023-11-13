import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kinde_flutter_sdk/kinde_flutter_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const DOCS_URL = "https://kinde.com/docs";
  static const HELP_URL = "https://kinde.com/docs";
  static const title = "KindeAuth";

  var kindeClient = KindeFlutterSDK.instance;

  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<UserProfileV2?> _profile = ValueNotifier(null);
  final ValueNotifier<bool> _loggedIn = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    kindeClient.isAuthenticate().then((value) {
      _loggedIn.value = value;
      if (value) {
        _getProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.viewPaddingOf(context).top,
            left: 16,
            right: 16,
            bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  ValueListenableBuilder(
                      valueListenable: _loading,
                      builder: (_, value, __) {
                        if (value) {
                          return const CircularProgressIndicator.adaptive();
                        } else {
                          return _trailingWidget();
                        }
                      }),
                ],
              ),
            ),
            SizedBox(height: 24),
            ValueListenableBuilder(
              valueListenable: _loggedIn,
              builder: (_, value, __) =>
              value ? _loggedInContent() : _initialContent(),
            ),
            Spacer(),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _trailingWidget() {
    return ValueListenableBuilder(
        valueListenable: _profile,
        builder: (_, value, __) {
          if (value != null) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipOval(
                      child: Container(
                        color: Color(0xFFF7F6F6),
                        alignment: Alignment.center,
                        child: Text(
                          '${value.givenName?[0]}${value.familyName?[0]}',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      kindeClient.logout().then((value) {
                        _loggedIn.value = false;
                        _profile.value = null;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${value.givenName} ${value.familyName}',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Text('Sign out'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Row(
              children: [
                MaterialButton(
                  padding: EdgeInsets.zero,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightElevation: 0,
                  elevation: 0,
                  onPressed: () {
                    kindeClient.login(type: AuthFlowType.pkce).then((token) {
                      if (token != null) {
                        _loggedIn.value = true;
                        _getProfile();
                      }
                    });
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF676767)),
                  ),
                ),
                MaterialButton(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  color: Colors.black,
                  onPressed: () {
                    kindeClient.register();
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )
              ],
            );
          }
        });
  }

  Widget _initialContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24),
          Text(
            "Let's Start\nauthenticating\nwith KindeAuth",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.white, fontSize: 32),
          ),
          SizedBox(height: 24),
          Text(
            "Configure your app",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 24),
          MaterialButton(
            elevation: 0,
            color: Colors.white,
            onPressed: () {
              launchUrl(Uri.parse(DOCS_URL));
            },
            child: const Text(
              'Go to docs',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loggedInContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Text(
                "Woohoo!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 24),
              ),
              SizedBox(height: 24),
              Text(
                "Your\nauthentication is\nall sorted.\nBuild the\nimportant stuff.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 32),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Next steps for you",
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 24),
        ),
      ],
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 24),
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
                text: 'Visit our ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 20),
                children: [
                  TextSpan(
                      text: 'help center',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(HELP_URL));
                        })
                ]),
          ),
          SizedBox(height: 8),
          Text(
            '© 2022 KindeAuth, Inc. All rights reserved',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF676767),
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  _getProfile() {
    _loading.value = true;
    kindeClient.getUserProfileV2().then((profile) async {
      _profile.value = profile;
    }).whenComplete(() => _loading.value = false);
  }
}
