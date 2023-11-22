import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Constants.appTitle,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 24),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
                text: 'Visit our ',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 20),
                children: [
                  TextSpan(
                      text: 'help center',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(Constants.docsUrl));
                        })
                ]),
          ),
          const SizedBox(height: 8),
          const Text(
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
}
