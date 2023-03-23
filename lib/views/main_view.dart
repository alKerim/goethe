import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/application_bloc.dart';
import '../application/application_event.dart';
import '../storage/Poem.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    Poem currentPoem = bloc.currentPoem;
    TextEditingController controller = TextEditingController();

    bool saved = false;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            child: const Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: () {
              if (!saved) {
                bloc.saveCurrentPoem();
                saved = true;
              }
            },
          ),
        ),
        Expanded(
          flex: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                currentPoem.title,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Text(
                currentPoem.poem,
                style: TextStyle(fontSize: 15),
              ),
              CupertinoButton(
                  child: Text(
                    "New Poem",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    BlocProvider.of<ApplicationBloc>(context)
                        .add(ApplicationInitialStartEvent());
                  })
            ],
          ),
        ),
      ],
    );
  }
}
