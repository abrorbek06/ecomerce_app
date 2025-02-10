// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreen extends StatefulWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late WebViewController _webViewController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Enable hybrid composition for Android if needed
//     WebView.platform = AndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Article'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               _webViewController.reload();
//             },
//           ),
//         ],
//       ),
//       body: WebView(
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (controller) {
//           _webViewController = controller;
//         },
//       ),
//     );
//   }
// }
