// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [GameView]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute({List<PageRouteInfo>? children})
    : super(GameRoute.name, initialChildren: children);

  static const String name = 'GameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GameView();
    },
  );
}

/// generated route for
/// [ResultView]
class ResultRoute extends PageRouteInfo<ResultRouteArgs> {
  ResultRoute({
    Key? key,
    required int shakeCount,
    List<PageRouteInfo>? children,
  }) : super(
         ResultRoute.name,
         args: ResultRouteArgs(key: key, shakeCount: shakeCount),
         initialChildren: children,
       );

  static const String name = 'ResultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResultRouteArgs>();
      return ResultView(key: args.key, shakeCount: args.shakeCount);
    },
  );
}

class ResultRouteArgs {
  const ResultRouteArgs({this.key, required this.shakeCount});

  final Key? key;

  final int shakeCount;

  @override
  String toString() {
    return 'ResultRouteArgs{key: $key, shakeCount: $shakeCount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResultRouteArgs) return false;
    return key == other.key && shakeCount == other.shakeCount;
  }

  @override
  int get hashCode => key.hashCode ^ shakeCount.hashCode;
}

/// generated route for
/// [TitleView]
class TitleRoute extends PageRouteInfo<void> {
  const TitleRoute({List<PageRouteInfo>? children})
    : super(TitleRoute.name, initialChildren: children);

  static const String name = 'TitleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TitleView();
    },
  );
}
