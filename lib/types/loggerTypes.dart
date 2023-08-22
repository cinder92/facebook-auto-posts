import 'package:flutter/material.dart';

enum LoggType { SUCCESS, CONSOLE, WARNING, ERROR }

const Map<LoggType, String> logsType = {
  LoggType.CONSOLE: 'console',
  LoggType.SUCCESS: 'success',
  LoggType.WARNING: 'warning',
  LoggType.ERROR: 'error'
};

const Map<LoggType, Color> logsColor = {
  LoggType.CONSOLE: Colors.white,
  LoggType.SUCCESS: Colors.green,
  LoggType.WARNING: Colors.yellow,
  LoggType.ERROR: Colors.red,
};
