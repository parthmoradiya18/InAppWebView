import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class provider extends ChangeNotifier
{
  InAppWebViewController? inAppWebViewController;
  double progress=0;

  void onprogresschnaged(double progress)
  {
    progress=progress;
    notifyListeners();
  }
}