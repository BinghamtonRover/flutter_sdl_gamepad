import Cocoa
import FlutterMacOS
import Foundation

public class FlutterSdlGamepadPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    setenv("SDLGAMEPAD_PATH", Bundle.main.privateFrameworksPath! + "/SDL3.framework/SDL3", 0);
  }
}