import 'package:ai_poetry/storage/Poem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/application_bloc.dart';
import '../application/application_event.dart';
import '../global_design/global_widgets.dart';

class SavedPoemsView extends StatelessWidget {
  const SavedPoemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    List<Poem> poems = bloc.poemStorage.poems;

    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
              child: GlobalDesign.cupertinoButtonChild("Back"),
              onPressed: () {
                BlocProvider.of<ApplicationBloc>(context)
                    .add(ApplicationBackToStartEvent());
                print("back clicked");
              },
            ),
          ),
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemCount: poems.length,
              itemBuilder: (context, index) {
                return Center(
                    child: Column(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(poems[index].title),
                      ),
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: CupertinoColors
                                      .secondarySystemBackground),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      poems[index].title,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(poems[index].poem,
                                        style: TextStyle(color: Colors.black)),
                                    CupertinoButton(
                                      child: GlobalDesign.cupertinoButtonChild(
                                          "Close"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    if (index < poems.length - 1) Divider()
                  ],
                ));
                //return Text(snapshot.data.toString());
              },
            ),
          ),
        ],
      ),
    );
  }

/*
  */
}
