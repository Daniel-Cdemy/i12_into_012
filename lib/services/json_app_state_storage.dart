import 'dart:convert';
import 'dart:io';

import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/services/app_state_storage.dart';
import 'package:path_provider/path_provider.dart';

class JsonAppStateStorage implements AppStateStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todo_app_state.json');
  }

  @override
  Future<void> save(AppState state) async {
    final file = await _localFile;
    final jsonString = jsonEncode(state.toJson());
    await file.writeAsString(jsonString);
  }

  @override
  Future<AppState?> load() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return null;

      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppState.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }
}
