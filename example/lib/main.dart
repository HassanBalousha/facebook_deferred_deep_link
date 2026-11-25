import 'package:facebook_deferred_deep_link/facebook_deferred_deep_link.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _deferredDeepLink = FacebookDeferredDeepLink();

  String _status = 'Fetching deferred deep link...';

  @override
  void initState() {
    super.initState();
    _fetchDeferredDeepLink();
  }

  Future<void> _fetchDeferredDeepLink() async {
    String status;
    try {
      final link = await _deferredDeepLink.fetchDeferredDeepLink();
      status = link == null ? 'No deferred deep link' : 'Deep link: $link';
    } on PlatformException catch (e) {
      status = 'Facebook SDK error: ${e.code} ${e.message ?? ''}';
    }

    if (!mounted) return;
    setState(() => _status = status);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Facebook deferred deep link')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_status, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
