BackgroundSplashPlugin
==================

This plugin allows the splashscreen to be shown when the app switcher is open.

This prevents unwanted users from looking at the content of your app.

Currently only working in iOS.

On iOS this plugin will try to show your splashscreen in the app switcher. It will search for splashscreens prefixed by `Default` or the value of the key `UILaunchImageFile` in your .plist file.
If it fails to find a splashscreen for a specific device or orientation (portrait or landscape), a black screen is shown instead.

Installation
------------

For Cordova 3.x.x:

1. To add this plugin just type: `cordova plugin add cordova-plugin-backgroundsplashplugin` or `phonegap local plugin add cordova-plugin-backgroundsplashplugin`
2. To remove this plugin type: `cordova plugin remove cordova-plugin-backgroundsplashplugin` or `phonegap local plugin remove cordova-plugin-backgroundsplashplugin`

Usage:
------

This plugin exposes no interface, it simply sets your app to be private. You don't need to do anything except install the plugin.

Test this plugin on a real device because the iOS simulator (7.1 at least) does a poor job hiding your app.

## License

The MIT License

Copyright (c) 2016 Armando Bártolo (http://github.com/armandobartolo)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

