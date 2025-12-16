import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/services/app_state_storage.dart';
import 'package:i12_into_012/services/json_app_state_storage.dart';
import 'package:i12_into_012/services/sqlite_app_state_storage.dart';

/*
Optionen: 
return JsonAppStateStorage(); = Json
return SqliteAppStateStorage(); = Sqlite
*/

final appStateStorageProvider = Provider<AppStateStorage>((ref) {
  return SqliteAppStateStorage();
});
