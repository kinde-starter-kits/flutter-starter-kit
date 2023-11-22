import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:kinde_flutter_sdk/kinde_api.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {super.key,
      this.profile,
      this.onLogin,
      this.onLogout,
      this.onRegister,
      this.loading = false});

  final VoidCallback? onLogin;
  final VoidCallback? onLogout;
  final VoidCallback? onRegister;
  final UserProfileV2? profile;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          Constants.appTitle,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        loading ? const CircularProgressIndicator.adaptive() : _trailingWidget(),
      ],
    );
  }

  Widget _trailingWidget() {
    if (profile != null) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: InkWell(
                  child: Container(
                    color: const Color(0xFFF7F6F6),
                    alignment: Alignment.center,
                    child: Text(
                      '${profile?.givenName?[0]}${profile?.familyName?[0]}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: onLogout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${profile?.givenName} ${profile?.familyName}',
                    style: const TextStyle(fontSize: 20),
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
            onPressed: onLogin,
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
            onPressed: onRegister,
            child: const Text(
              'Sign up',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        ],
      );
    }
  }
}
