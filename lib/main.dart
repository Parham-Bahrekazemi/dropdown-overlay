import 'package:drop_down_widget/widgets/portal_overlay_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final OverlayPortalController overlayController = OverlayPortalController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PortalOverlay(
            overlayController: overlayController,
          ),
        ),
      ),
    );
  }
}
