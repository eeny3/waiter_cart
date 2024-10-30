import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void initializeLocator() => getIt.init();