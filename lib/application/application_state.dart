class ApplicationState {}

class ApplicationStartState extends ApplicationState {
  final String? error;
  ApplicationStartState({this.error});
}

class ApplicationLoadingCompletionRequest extends ApplicationState {}

class ApplicationShowingCompletion extends ApplicationState {}

class ApplicationLoadingSavedPoems extends ApplicationState {}

class ApplicationShowingSavedPoems extends ApplicationState {}
