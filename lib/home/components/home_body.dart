import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.loggedIn});

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return loggedIn ? _loggedInContent() : _initialContent();
  }

  Widget _initialContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          const Text(
            "Let's Start\nauthenticating\nwith KindeAuth",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.white, fontSize: 32),
          ),
          const SizedBox(height: 24),
          const Text(
            "Configure your app",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 24),
          MaterialButton(
            elevation: 0,
            color: Colors.white,
            onPressed: () {
              launchUrl(Uri.parse(Constants.docsUrl));
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
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: const Column(
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
        const SizedBox(height: 16),
        const Text(
          "Next steps for you",
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 24),
        ),
      ],
    );
  }
}
