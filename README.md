# flutter_sdl_gamepad

A Flutter wrapper to compile all the libraries needed by [package:sdl_gamepad](https://pub.dev/packages/sdl_gamepad).

This library is needed as the SDL binaries are not included with `package:sdl_gamepad`, at least
not until the Native Assets feature is released. This package simply exports it and instructs the
Flutter tooling to compile and build SDL3's native code.

This package is supported and tested on Windows and Linux. MacOS support is expected but currently untested.
