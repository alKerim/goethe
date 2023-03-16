import 'dart:convert';
import 'dart:io';

import 'package:ai_poetry/openai_api/completions_response.dart';
import 'package:ai_poetry/storage/PoemStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../openai_api/completions_api.dart';
import '../openai_api/moderations_response.dart';
import '../storage/Poem.dart';
import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  String basePrompt = "Random 1 to 2 verse poem about the topic";
  String prompt = "bird";
  String completePrompt = "Random poem about bird";
  String? currentCompletion;

  Poem currentPoem = Poem("Error", "Error");

  PoemStorage poemStorage = PoemStorage([]);

  ApplicationBloc() : super(ApplicationStartState()) {
    on<ApplicationInitialStartEvent>(
        (event, emit) => emit(ApplicationStartState()));
    on<ApplicationRequestCompletionEvent>((event, emit) async {
      // just avoiding spam of empty prompts
      if (event.prompt.isEmpty) return;

      prompt = event.prompt;
      completePrompt = "$basePrompt $prompt";

      emit(ApplicationLoadingCompletionRequest());
      try {
        ModerationsResponse moderationResponse =
            await CompletionsAPI.getModerationClassification(prompt);
        if (moderationResponse.flagged != null && moderationResponse.flagged!) {
          print("SENSITIVE/ EXPLICIT");
          emit(ApplicationStartState(error: "Too explicit. Please use "));
        } else {
          print("VALID (Not explicit)");
          CompletionsResponse response =
              await CompletionsAPI.getNewPoem(completePrompt);
          currentCompletion = response.firstCompletion.toString();
          currentPoem = Poem(prompt, currentCompletion.toString());
          emit(ApplicationShowingCompletion());
        }
      } on Exception catch (_) {
        print("ERROR ${event}");
      }
    });
    on<ApplicationCompletionLoadedEvent>(
        (event, emit) => emit(ApplicationShowingCompletion()));
    on<ApplicationOpenSavedPoemsEvent>(
            (event, emit) async {
              emit(ApplicationLoadingSavedPoems());
              try {
                print("Loading saved poems");

                poemStorage = await readPoems();
                emit(ApplicationShowingSavedPoems());
              }
              catch(e) {
                print("Error: $event");
              }
            });
    on<ApplicationBackToStartEvent>(
            (event, emit) => emit(ApplicationStartState()));
  }

  Future<PoemStorage> readPoems() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return PoemStorage.fromJson(contents);

    } catch (e) {
      return PoemStorage([]);
    }
  }

  Future<File> _writePoems(PoemStorage poemStorage) async {
    // Convert poemStorage to Json
    String jsonBody = json.encode(poemStorage.toJson());

    // Write the file
    final file = await _localFile;
    return file.writeAsString(jsonBody);
  }

  Future<void> _saveNewPoem(Poem newPoem) async {
    PoemStorage poemStorage = await readPoems();
    poemStorage.poems.add(newPoem);
    _writePoems(poemStorage);
  }

  /// Is only available in new Poem view
  Future<void> saveCurrentPoem() async {
    /// Add current poem to saved poems
    await _saveNewPoem(currentPoem);
  }

  Future<File> get _localFile async {
    print("About to call: _localPath");
    final String path = await _localPath;
    print("Got the path: $path");
    return File('$path/poem-storage.txt');
  }


  Future<String> get _localPath async {
    print("About to call: getApplicationDocumentsDirectory");
    final directory = await getApplicationDocumentsDirectory();
    print("About to return: Documents path");

    return directory.path;
  }
}
