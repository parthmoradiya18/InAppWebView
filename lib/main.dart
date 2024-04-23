
import 'package:flutter/material.dart';
import 'package:inappwebview/inappwebview.dart';
import 'package:inappwebview/provider.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => provider(),),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/':(context) => InAppWebview(),
          },
        ),
      )
  );
}