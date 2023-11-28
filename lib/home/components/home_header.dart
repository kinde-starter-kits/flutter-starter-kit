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
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: InkWell(
                  child: Container(
                    color: kColorLightGrey,
                    alignment: Alignment.center,
                    child: Text(
                      '${profile?.givenName?[0]}${profile?.familyName?[0]}',
                      style: kTitleText,
                    ),
                  ),
                ),
              ),
            ),
            horizontalSpaceRegular,
            InkWell(
              onTap: onLogout,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${profile?.givenName} ${profile?.familyName}',
                    style: kRobotoText.copyWith(fontSize: kHeadingTwo),
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
