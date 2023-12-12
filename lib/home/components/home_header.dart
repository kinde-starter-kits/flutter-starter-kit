import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:kinde_flutter_sdk/kinde_api.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key,
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
    return TrailingWidget(profile: profile,
      loading: loading,
      onLogin: onLogin,
      onRegister: onRegister,
      onLogout: onLogout,
    );
  }
}


class TrailingWidget extends StatelessWidget {
  final void Function()? onLogin;
  final void Function()? onRegister;
  final void Function()? onLogout;
  final bool loading;
  final UserProfileV2? profile;
  const TrailingWidget(
      {super.key,
        this.onLogin,
        this.onLogout, this.onRegister,
        this.profile,
        required this.loading});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const CircularProgressIndicator.adaptive();
    } else {
      if (profile != null) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                appTitle,
                style: kTitleText,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: kColorLightGrey,
                  shape: BoxShape.circle,),
                child: Text(
                  '${profile?.givenName?[0]}${profile?.familyName?[0]}',
                  style: kTitleText,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: onLogout,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${profile?.givenName} ${profile?.familyName}',
                        style: kRobotoText.copyWith(fontSize: kHeadingTwo),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    verticalSpaceRegular,
                    const Text('Sign out'),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Expanded(
              child: Text(
                appTitle,
                style: kTitleText,
              ),
            ),
            Expanded(
              child: Row(children: [
                MaterialButton(
                  padding: EdgeInsets.zero,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightElevation: 0,
                  elevation: 0,
                  onPressed: onLogin,
                  child: Text(
                    'Sign in',
                    style: kRobotoText.copyWith(
                        fontWeight: kFwBold, color: kColorGrey),
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
              ],),
            )

          ],
        );
      }
    }
  }
}
