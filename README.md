# Cordova-Plugin-Native-Logs
A Cordova plugin to retrieve native logs directly from your app to let your users easily share them with you for troubleshooting
Those logs will be identical to the ones retrieved by the `adb logcat` command (Android), or displayed in  XCode debugger (iOS)

#### Platform support

* iOS
* Android

#### Installing

```
cordova plugin add cordova-plugin-native-logs
```

#### Uninstalling

```
cordova plugin remove cordova-plugin-native-logs
```

#### Usage

```
NativeLogs.getLog(_nbLines,_bCopyToClipboard,_successCB)
```
Returns the latest available logs.

##### Params
* `_nbLines`: number max of lines to retrieve 
* `_bCopyToClipboard`: copy the logs to the clipboard to let the user easily share it
* `_successCB`: callback that will retrieve the log as a string

#### Example

```
NativeLogs.getLog(1000,false, function(_logs) {
// do something w/ the logs
}
```
#### Ionic Framework Support

To use the plugin in your project, just add this declaration :
```
declare var NativeLogs:any;
```

A complete functional sample is available in the `sample/` directory in the github website: https://github.com/ogoguel/cordova-plugin-native-logs

To build it : 
```
cd sample/
ionic state reset
ionic run ios
ionic run android
```

#### Screenshots
![IOS Screenshot](https://raw.githubusercontent.com/ogoguel/cordova-plugin-native-logs/master/sample/screenshots/ios.png)
#### Send logs through Email

This plugin can be used in conjunction with mail composer plugin to let the user send the log via email

#### History

* v1.0.5 Fix version mismatched
* v1.0.4 Fix NPM deployment
* v1.0.3 Fix invalid log count (cf. issue #1)
* v1.0.2 Fix typo in documentation
* v1.0.1 Initial release