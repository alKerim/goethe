import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../application/application_bloc.dart';
import '../application/application_event.dart';
import '../global_design/global_widgets.dart';

class StartView extends StatefulWidget {
  final String? optionalErrorMessage;
  TextEditingController controller = TextEditingController();

  StartView({Key? key, this.optionalErrorMessage}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  String? optionalErrorMessage;

  @override
  initState() {
    optionalErrorMessage = widget.optionalErrorMessage;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(hasErrorNotification()) {
        errorNotification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.square_favorites_alt_fill, color: Colors.black,),
            onPressed: () {
              BlocProvider.of<ApplicationBloc>(context).add(
                  ApplicationOpenSavedPoemsEvent());
            },
          ),
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                    "You think you a poet huh!!? \n"
                    "type in a keyword and see the allgorithm does it faster/better than you.",
                    textAlign: TextAlign.center),
                CupertinoTextField(
                  controller: widget.controller,
                  placeholder:
                      "path of the warrior, fashion lovers, whatever...",
                  maxLength: 50,
                  style: const TextStyle(color: Colors.black),
                  placeholderStyle: const TextStyle(color: Colors.black26),
                  decoration: const BoxDecoration(color: Colors.white),
                  cursorColor: Colors.black,
                ),
                CupertinoButton(
                    child: GlobalDesign.cupertinoButtonChild("Poetize"),
                    onPressed: () {
                      BlocProvider.of<ApplicationBloc>(context).add(
                          ApplicationRequestCompletionEvent(
                              widget.controller.value.text));
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool hasErrorNotification() {
    return optionalErrorMessage != null;
  }

  void errorNotification() {
    showSimpleNotification(
      const Text("Too much profanity."),
      background: Colors.redAccent,
      autoDismiss: true,
      duration: const Duration(seconds: 5),
      trailing: Builder(builder: (context) {
        return CupertinoButton(
            onPressed: () {
              OverlaySupportEntry.of(context)?.dismiss();
            },
            child: const Text('Dismiss', style: TextStyle(color: Colors.white),));
      }),
    );
    setState(() {
      optionalErrorMessage = null;
    });
  }

}
