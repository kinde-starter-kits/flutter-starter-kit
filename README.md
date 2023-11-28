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
   
Example:

           loginRedirectUri: 'com.kinde.myapp://kinde_callback',
           logoutRedirectUri: 'com.kinde.myapp://kinde_logoutcallback',
5. Select Save.

**Note:** The custom scheme can either match your appId/bundleId or be something completely new as long as it's distinct enough. Using the appId/bundleId of your app is quite common but it's not always possible if it contains illegal characters for URI schemes (like underscores) or if you already have another handler for that scheme - so just use something else.

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

If you’re using an `.env` file, provide the .env filename inside the load function. See below:

            await KindeFlutterSDK.initializeSDK(
                authDomain: dotenv.env['KINDE_AUTH_DOMAIN']!,
                authClientId: dotenv.env['KINDE_AUTH_CLIENT_ID']!,
                loginRedirectUri: dotenv.env['KINDE_LOGIN_REDIRECT_URI']!,
                logoutRedirectUri: dotenv.env['KINDE_LOGOUT_REDIRECT_URI']!,
                audience: dotenv.env['KINDE_AUDIENCE'], //optional
                scopes: ["email","profile","offline","openid"] // optional
            );

**Note**: To setup the .env file in your flutter package, check the **[flutter_dotenv](https://pub.dev/packages/flutter_dotenv)** package.

### Environment variables:
Put these variables in your .env file. You can find these variables on your **Settings > Applications > [Your app] > View details** page.

* `KINDE_AUTH_DOMAIN` - your Kinde domain
* `KINDE_CLIENT_ID` - your Kinde client ID 
* `KINDE_LOGIN_REDIRECT_URI` - your callback url to redirect to after authentication. Make sure this URL is under your **Allowed callback URLs**. 
* `KINDE_LOGOUT_REDIRECT_URI` - where you want users to be redirected to after logging out. Make sure this URL is under your **Allowed logout redirect URLs**. 
* `KINDE_AUDIENCE` (optional)- the intended recipient of an access token. To fetch this value, go to **Settings > Applications > [Your app] > APIs**

Below is an example of a `.env` file

```
KINDE_AUTH_DOMAIN=https://<your_kinde_subdomain>.kinde.com
KINDE_AUTH_CLIENT_ID=<your_kinde_client_id>
KINDE_LOGIN_REDIRECT_URI=<your_custom_scheme>://kinde_callback
KINDE_LOGOUT_REDIRECT_URI=<your_custom_scheme>://kinde_logoutcallback
KINDE_AUDIENCE=<your_kinde_audience>
```
**Example:**

```
KINDE_AUTH_DOMAIN='https://myapp.kinde.com'
KINDE_AUTH_CLIENT_ID='clientid'
KINDE_LOGIN_REDIRECT_URI='com.kinde.myapp://kinde_callback'
KINDE_LOGOUT_REDIRECT_URI='com.kinde.myapp://kinde_logoutcallback'
KINDE_AUDIENCE='myapp.kinde.com/api'```
