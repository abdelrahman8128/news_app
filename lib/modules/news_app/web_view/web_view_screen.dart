
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  WebViewScreen(this.url);
  late final WebViewController webViewController = WebViewController()
    ..loadRequest(Uri.parse(url),
    )
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
        },

      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
