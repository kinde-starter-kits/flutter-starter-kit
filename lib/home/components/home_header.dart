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
        Text(
          appTitle,
          style: kTitleText,
        ),
        loading
            ? const CircularProgressIndicator.adaptive()
            : _trailingWidget(),
      ],
    );
  }

  Widget _trailingWidget() {
    if (profile != null) {
      return MaterialButton(
        padding: EdgeInsets.zero,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightElevation: 0,
        elevation: 0,
        onPressed: onLogout,
        child: Text(
          'Sign out',
          style: kRobotoText.copyWith(fontWeight: kFwBold, color: kColorGrey),
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
            child: Text(
              'Sign in',
              style:
                  kRobotoText.copyWith(fontWeight: kFwBold, color: kColorGrey),
            ),
          ),
          MaterialButton(
            elevation: 0,
            padding: EdgeInsets.zero,
            color: Colors.black,
            onPressed: onRegister,
            child: Text(
              'Sign up',
              style: kRobotoText.copyWith(
                  fontWeight: kFwBold, color: Colors.white),
            ),
          )
        ],
      );
    }
  }
}
