import 'dart:io';

import '../../common/menu/menu.dart';
import '../../common/utils/logger/log_utils.dart';
import '../../core/internationalization.dart';
import '../../core/locales.g.dart';
import '../../core/structure.dart';

Future<bool> createMain() async {
  var newFileModel = Structure.model('', 'init', false);

  var main = File('${newFileModel.path}main.dart');

  if (main.existsSync()) {
    /// Only the create project and init functions call this function,
    /// both functions initialize a project and overwrite the files.

    final menu = Menu([LocaleKeys.options_yes.tr, LocaleKeys.options_no.tr],
        title: LocaleKeys.ask_lib_not_empty.tr);
    final result = menu.choose();
    if (result.index == 1) {
      LogService.info(LocaleKeys.info_no_file_overwritten.tr);
      return false;
    }
    await Directory('lib/').delete(recursive: true);
  }
  return true;
}
