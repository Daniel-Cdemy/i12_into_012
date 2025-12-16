import 'package:i12_into_012/models/app_state.dart';

abstract class AppStateStorage {
  Future<AppState?> load();
  Future<void> save(AppState state);
}
