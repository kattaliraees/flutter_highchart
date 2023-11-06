import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    _setupWebViewWidget();
  }

  @override
  Widget build(BuildContext context) {
    return _pieChartWebView();
  }

  void _setupWebViewWidget() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..clearCache()
      ..setBackgroundColor(Colors.transparent)
      ..loadFlutterAsset('assets/js/hc_index.html')
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          const xyValue = ''' 
      [
        {
            name: 'Browsers',
            colorByPoint: true,
            data: [
                {
                    name: 'Chrome',
                    y: 61.04,
                    drilldown: 'Chrome'
                },
                {
                    name: 'Safari',
                    y: 9.47,
                    drilldown: 'Safari'
                },
                {
                    name: 'Edge',
                    y: 9.32,
                    drilldown: 'Edge'
                },
                {
                    name: 'Firefox',
                    y: 8.15,
                    drilldown: 'Firefox'
                },
                {
                    name: 'Other',
                    y: 11.02,
                    drilldown: null
                }
            ]
        }
    ]
    ''';
          webViewController.runJavaScript('jsPieChartFunc($xyValue);');
        },
      ));

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(kDebugMode);
    }

    if (webViewController.platform is WebKitWebViewController) {
      final WebKitWebViewController webKitWebViewController =
          webViewController.platform as WebKitWebViewController;
      webKitWebViewController.setInspectable(kDebugMode);
    }
  }

  Widget _pieChartWebView() {
    return SizedBox(
        height: 300,
        child: WebViewWidget(
          controller: webViewController,
        ));
  }
}
