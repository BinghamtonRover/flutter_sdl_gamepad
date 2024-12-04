import "dart:async";

import "package:flutter_sdl_gamepad/flutter_sdl_gamepad.dart";
import "package:flutter/material.dart";

void main() => runApp(const MaterialApp(home: GamepadPage()));

class GamepadPage extends StatefulWidget {
  const GamepadPage({super.key});

  @override
  GamepadPageState createState() => GamepadPageState();
}

class GamepadPageState extends State<GamepadPage> {
  Timer? timer;
  String? error;
  SdlGamepad? gamepad;
  GamepadState? state;

  final gamepadInfo = <int, String>{};

  bool get hasError => error != null;

  @override
  void initState() {
    super.initState();
    if (!SdlLibrary.init()) {
      error = "Could not initialize SDL: ${SdlLibrary.getError()}";
      SdlLibrary.dispose();
      return;
    }
    checkGamepads();
    timer = Timer.periodic(const Duration(milliseconds: 100), refreshState);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkGamepads() {
    setState(() => error = null);
    gamepadInfo.clear();
    final gamepads = SdlGamepad.getConnectedGamepadIds();
    for (final gamepadId in gamepads) {
      final info = SdlGamepad.getInfoForGamepadId(gamepadId);
      final message =
        "  Name: ${info.name}\n"
        "  Gamepad type: ${info.type}\n";
      gamepadInfo[gamepadId] = message;
    }
    setState(() { });
  }

  void refreshState(_) {
    if (gamepad == null) return;
    setState(() => state = gamepad!.getState());
  }

  void selectGamepad(int gamepadId) {
    setState(() => error = null);
    setState(() => gamepad = SdlGamepad.fromGamepadIndex(gamepadId));
    if (!gamepad!.isConnected) {
      gamepad = null;
      setState(() => error = "That gamepad is not connected");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Row(
      children: [
        Expanded(
          child: Column(  // list of gamepads
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              FilledButton.icon(
                label: const Text("Refresh"),
                icon: const Icon(Icons.refresh),
                onPressed: checkGamepads,
              ),
              const SizedBox(height: 12),
              if (gamepadInfo.isEmpty)
                const Text("There are no gamepads connected"),
              for (final entry in gamepadInfo.entries) ListTile(
                title: Text("Gamepad: ${entry.key}"),
                subtitle: Text(entry.value),
                onTap: () => selectGamepad(entry.key),
              ),
            ],
          ),
        ),
        if (state == null)
          const Expanded(child: Text("Choose a gamepad"))
        else ...[
          Expanded(child: Thumbstick(label: "Left joystick", x: state!.normalLeftJoystickX, y: state!.normalLeftJoystickY)),
          Expanded(child: Thumbstick(label: "Right joystick", x: state!.normalRightJoystickX, y: state!.normalRightJoystickY)),
        ],
      ],
    ),
  );
}

class Thumbstick extends StatelessWidget {
  final double x;
  final double y;
  final String label;
  const Thumbstick({required this.x, required this.y, required this.label, super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(label, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 12),
      Container(
        width: 50,
        height: 50,
        decoration: const ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(color: Colors.black),
          ),
        ),
        child: Align(
          alignment: Alignment(x, y),
          child: const SizedBox(
            width: 25,
            height: 25,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
