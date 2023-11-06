import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class LineChartScreen extends StatelessWidget {
  LineChartScreen({super.key});

  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..enableZoom(false)
    ..clearCache()
    ..setBackgroundColor(Colors.transparent)
    ..loadFlutterAsset('assets/js/hc_index.html')
    ..setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        if (webViewController.platform is AndroidWebViewController) {
          AndroidWebViewController.enableDebugging(kDebugMode);
        }

        if (webViewController.platform is WebKitWebViewController) {
          final WebKitWebViewController webKitWebViewController =
              webViewController.platform as WebKitWebViewController;
          webKitWebViewController.setInspectable(kDebugMode);
        }
      },
      onPageFinished: (url) {
        const xyValue = ''' 
                [{
                  name: 'Installation & Developers',
                  data: [43934, 48656, 65165, 81827, 112143, 142383,
                      171533, 165174, 155157, 161454, 154610]
                  }, {
                      name: 'Manufacturing',
                      data: [24916, 37941, 29742, 29851, 32490, 30282,
                          38121, 36885, 33726, 34243, 31050]
                  }, {
                      name: 'Sales & Distribution',
                      data: [11744, 30000, 16005, 19771, 20185, 24377,
                          32147, 30912, 29243, 29213, 25663]
                  }, {
                      name: 'Operations & Maintenance',
                      data: [null, null, null, null, null, null, null,
                          null, 11164, 11218, 10077]
                  }, {
                      name: 'Other',
                      data: [21908, 5548, 8105, 11248, 8989, 11816, 18274,
                          17300, 13053, 11906, 10073]
                  }]
        ''';
        webViewController.runJavaScript('jsLineChartFunc($xyValue);');
      },
    ));

  @override
  Widget build(BuildContext context) {
    return _lineChartWebView();
  }

  Widget _lineChartWebView() {
    return SizedBox(
        height: 300,
        child: WebViewWidget(
          controller: webViewController,
        ));
  }
}
