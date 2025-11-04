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
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    Key? key,
    int requiredShakeCount = 40,
    List<PageRouteInfo>? children,
  }) : super(
         GameRoute.name,
         args: GameRouteArgs(
           key: key,
           requiredShakeCount: requiredShakeCount,
         ),
         initialChildren: children,
       );

  static const String name = 'GameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameRouteArgs>();
      return GameView(
        key: args.key,
        requiredShakeCount: args.requiredShakeCount,
      );
    },
  );
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    this.requiredShakeCount = 40,
  });

  final Key? key;

  final int requiredShakeCount;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, requiredShakeCount: $requiredShakeCount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameRouteArgs) return false;
    return key == other.key &&
        requiredShakeCount == other.requiredShakeCount;
  }

  @override
  int get hashCode => key.hashCode ^ requiredShakeCount.hashCode;
}

/// generated route for
/// [ResultView]
class ResultRoute extends PageRouteInfo<ResultRouteArgs> {
  ResultRoute({
    Key? key,
    required int shakeCount,
    int requiredShakeCount = 40,
    List<PageRouteInfo>? children,
  }) : super(
         ResultRoute.name,
         args: ResultRouteArgs(
           key: key,
           shakeCount: shakeCount,
           requiredShakeCount: requiredShakeCount,
         ),
         initialChildren: children,
       );

  static const String name = 'ResultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResultRouteArgs>();
      return ResultView(
        key: args.key,
        shakeCount: args.shakeCount,
        requiredShakeCount: args.requiredShakeCount,
      );
    },
  );
}

class ResultRouteArgs {
  const ResultRouteArgs({
    this.key,
    required this.shakeCount,
    this.requiredShakeCount = 40,
  });

  final Key? key;

  final int shakeCount;

  final int requiredShakeCount;

  @override
  String toString() {
    return 'ResultRouteArgs{key: $key, shakeCount: $shakeCount, requiredShakeCount: $requiredShakeCount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResultRouteArgs) return false;
    return key == other.key &&
        shakeCount == other.shakeCount &&
        requiredShakeCount == other.requiredShakeCount;
  }

  @override
  int get hashCode =>
      key.hashCode ^ shakeCount.hashCode ^ requiredShakeCount.hashCode;
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
