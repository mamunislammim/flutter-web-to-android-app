
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    _loadWebView();
    if (_webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  void _loadWebView() async{
    try {
      _webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url));
    } catch (e) {
      print('Error loading web view: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      //backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child:  WebViewWidget(
          controller: _webViewController,
        ),
      ),
    );
  }
}