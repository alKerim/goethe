class ApplicationEvent {}

class ApplicationInitialStartEvent extends ApplicationEvent {}

class ApplicationRequestCompletionEvent extends ApplicationEvent {
  String prompt;
  ApplicationRequestCompletionEvent(this.prompt);
}

class ApplicationCompletionLoadedEvent extends ApplicationEvent {}

class ApplicationOpenSavedPoemsEvent extends ApplicationEvent {}

class ApplicationBackToStartEvent extends ApplicationEvent {}

