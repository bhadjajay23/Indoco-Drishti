import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  double progress = 0;

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useOnDownloadStart: true,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      javaScriptEnabled: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      loadWithOverviewMode: true,
      useWideViewPort: false,
      builtInZoomControls: false,
      domStorageEnabled: true,
      supportMultipleWindows: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SafeArea(
                    child: InAppWebView(
                      // initialUrlRequest:
                      //     URLRequest(url: Uri.parse("http://www.ramansheeinfotech.com")),
                      initialUrlRequest: URLRequest(
                          url: WebUri("https://idsmodev.indoco.com")),
                      // initialOptions: _options,
                      onWebViewCreated: (controller) {},
                      onLoadStart: (controller, url) {
                        // Show loading indicator etc
                      },
                      onLoadStop: (controller, url) {
                        // Hide loading indicator etc
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onDownloadStartRequest:
                          (controller, downloadStartRequest) {
                        final uri = downloadStartRequest.url;
                        if (kDebugMode) {
                          print("uri = $uri");
                        }
                        launchUrl(uri);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: _buildProgressBar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    if (progress != 1.0) {
      return const CircularProgressIndicator(color: Colors.black);
    }
    return Container();
  }
}
