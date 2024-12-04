import "dart:io";
import "dart:ffi";

import "package:sdl3/sdl3.dart" as sdl;
import "package:sdl_gamepad/sdl_gamepad.dart";

export "package:sdl_gamepad/sdl_gamepad.dart";

/// The wrapper plugin. Use [SdlGamepad] directly.
class FlutterSdlGamepad {
  /// Flutter will call this method on launch. On Mac, loads the dylib needed by SDL3.
  static void registerWith() {
    if (Platform.isMacOS) {
      final path = Platform.environment["SDLGAMEPAD_PATH"];
      final lib = DynamicLibrary.open(path!);
      sdl.SdlDynamicLibraryService().add("SDL3", lib);
    }
  }
}
