import 'dart:async';

import 'package:test_game/src/core/utils/refined_logger.dart';
import 'package:test_game/src/feature/initialization/logic/app_runner.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );
