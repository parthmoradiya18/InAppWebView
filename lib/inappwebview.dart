
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inappwebview/provider.dart';
import 'package:provider/provider.dart';

class InAppWebview extends StatefulWidget {
  const InAppWebview({Key? key}) : super(key: key);

  @override
  State<InAppWebview> createState() => _InAppWebviewState();
}

class _InAppWebviewState extends State<InAppWebview> {
  provider? providertrue;
  provider? providerfalse;
  TextEditingController search=TextEditingController();
  PullToRefreshController? pullToRefreshController;
  @override
  void initState() {
    pullToRefreshController=PullToRefreshController(
      onRefresh: () {
        providertrue!.inAppWebViewController!.reload();
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    providertrue=Provider.of<provider>(context,listen: true);
    providerfalse=Provider.of<provider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.topCenter,
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,color: Colors.white,
                  ),
                  onPressed: () {
                    String newLink = search.text;
                    providertrue!.inAppWebViewController?.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(
                          "https://www.google.com/search?q=$newLink",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            LinearProgressIndicator(value: providertrue!.progress ),

            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                URLRequest(url: Uri.parse("https://www.google.com/")),
                onWebViewCreated: (controller) {
                  providertrue!.inAppWebViewController = controller;
                },

                onProgressChanged: (controller, progress) {
                  providerfalse!.onprogresschnaged(progress/100);
                },
                onLoadError: (controller, url, code, message) {
                  providertrue!.inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  providertrue!.inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) {
                  providertrue!.inAppWebViewController = controller;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          providertrue!.inAppWebViewController!.goBack();
                        },
                        child: Icon(Icons.arrow_back,color: Colors.white,)),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(
                        onTap: () {
                          providertrue!.inAppWebViewController!.reload();
                        },
                        child: Icon(Icons.refresh,color: Colors.white,)),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(
                        onTap: () {
                          providertrue!.inAppWebViewController!.goForward();
                        },
                        child: Icon(Icons.arrow_forward_outlined,color: Colors.white,)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}