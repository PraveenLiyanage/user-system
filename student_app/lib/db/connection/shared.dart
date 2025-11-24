// lib/db/connection/shared.dart

export 'unsupported.dart'
    if (dart.library.js) 'web.dart'
    if (dart.library.io) 'native.dart';
