import "dart:io";
import "package:sdl3/sdl3.dart" as sdl;
export "package:sdl_gamepad/sdl_gamepad.dart";

class FlutterSdlGamepad {
  static void registerWith() {
    if (Platform.isMacOS){
      // look at flutter_sdl_gamepad
    final path = Platform.environment["SDLGAMEPAD_PATH"];
    sdl.openLib(path!);
    }
  }
}

