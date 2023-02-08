import 'package:ai_poetry/application/application_state.dart';
import 'package:ai_poetry/views/saved_poems_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/loading_view.dart';
import '../views/main_view.dart';
import '../views/start_view.dart';
import 'application_bloc.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({Key? key}) : super(key: key);

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);

    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ApplicationStartState:
            {
              if ((state as ApplicationStartState).error != null) {
                return StartView(
                    optionalErrorMessage:
                        (state as ApplicationStartState).error!);
              }
              return StartView();
            }
          case ApplicationLoadingCompletionRequest:
            return const LoadingView();
          case ApplicationShowingCompletion:
            return MainView();
          case ApplicationLoadingSavedPoems:
            return const LoadingView();
          case ApplicationShowingSavedPoems:
            return SavedPoemsView();
          default:
            return StartView();
        }
      },
    );
  }
}
