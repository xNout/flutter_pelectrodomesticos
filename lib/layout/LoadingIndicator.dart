import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}

class LoadingOverlay {
  static final LoadingOverlay _singleton = LoadingOverlay._internal();
  factory LoadingOverlay() => _singleton;

  LoadingOverlay._internal();

  OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => const LoadingIndicator(),
      );
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
