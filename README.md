# Kinde Starter Kits - Flutter

The [Kinde Flutter Starter Kits](https://github.com/kinde-starter-kits/flutter-starter-kit) are simple apps
that demonstrate how to integrate your app with the Kinde authentication service and management API.

## Set up Kinde environment

To get started set up an account on [Kinde](https://app.kinde.com/register).
1. In Kinde, go to Settings > Applications.
2. Select View details on your app. 
3. Scroll down to the Callback URLs section.
4. Add in the callback URLs for your app, which might look something like this:
   - Allowed callback URLs: <your_custom_scheme>://kinde_callback
   - Allowed logout redirect URLs: <your_custom_scheme>://kinde_logoutcallback

          loginRedirectUri: 'com.kinde.myapp://kinde_callback',
          logoutRedirectUri: 'com.kinde.myapp://kinde_logoutcallback',
5. Select Save.

## Setup flutter project
### Android Setup

Go to the build.gradle file in the Android > App folder for your Android app.

Specify the custom scheme similar to the following, but replace <your_custom_scheme> with your own value.

          android {
            ...
            defaultConfig {
                ...
                manifestPlaceholders += [
                        'appAuthRedirectScheme': '<your_custom_scheme>'
                ]
            }
        }

### iOS Setup

Go to the Info.plist located at ios > Runner for your iOS/macOS app.

Specify the custom scheme similar to the following but replace <your_custom_scheme> with your own value.

           <key>CFBundleURLTypes</key>
            <array>
                <dict>
                    <key>CFBundleTypeRole</key>
                    <string>Editor</string>
                    <key>CFBundleURLSchemes</key>
                    <array>
                        <string><your_custom_scheme></string>
                    </array>
                </dict>
            </array>

## initialize Kinde SDK

Find this configuration block in `main.dart` file

            await KindeFlutterSDK.initializeSDK(
                authDomain: "<your_kinde_domain>",
                authClientId: "<client_id>",
                loginRedirectUri: '<your_custom_scheme>://kinde_callback',
                logoutRedirectUri: '<your_custom_scheme>://kinde_logoutcallback',
                audience: '<audience>', //optional
                scopes: ["email","profile","offline","openid"] // optional
            );  

Then replace the values you see in `<code brackets>` with your own values from **Settings > Applications > [Your app] > View details page**.

To fetch value for `<audience>`, go to **Settings > Applications > [Your app] > APIs**
