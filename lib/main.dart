import 'package:ai_poetry/application/application_bloc.dart';
import 'package:ai_poetry/application/application_view.dart';
import 'package:ai_poetry/openai_api/completions_response.dart';
import 'package:ai_poetry/views/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'openai_api/completions_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(fontFamily: 'TimesNewRoman')),
        ),
        home: BlocProvider<ApplicationBloc>(
            create: (context) => ApplicationBloc(),
            child: Scaffold(
              //color: Colors.white,
                body: ApplicationView()),
          ),
      ),
    );
  }
}
