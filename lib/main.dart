import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:epic_edit/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  Window.initialize();
  
  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(400, 780),
    size: Size(800, 600),
    center: true,
    title: 'Epic Edit'
  );

  windowManager.setResizable(true);
  
  windowManager.setAsFrameless();
   
  Window.setEffect(
    effect: WindowEffect.transparent
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setHasShadow(false);
    windowManager.show();
  });

  doWhenWindowReady(() {
    appWindow.show();
    
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              /// Fake window border
              child!,
              /// Window Caption
              const SizedBox(
                width: double.infinity,
                height: 27,
                child: WindowCaption(),
              ),
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        useMaterial3: false,
      ),
    );
  }
}
