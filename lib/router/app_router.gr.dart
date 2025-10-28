// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  _$AppRouter();

  @override
  final Map<String, PageFactory> pagesMap = {
    GameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GameView(),
      );
    },
    ResultRoute.name: (routeData) {
      final args = routeData.argsAs<ResultRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResultView(
          key: args.key,
          shakeCount: args.shakeCount,
        ),
      );
    },
    TitleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TitleView(),
      );
    },
  };
}

/// generated route for
/// [GameView]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute({List<PageRouteInfo>? children})
      : super(
          GameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
          args: ResultRouteArgs(
            key: key,
            shakeCount: shakeCount,
          ),
          initialChildren: children,
        );

  static const String name = 'ResultRoute';

  static const PageInfo<ResultRouteArgs> page = PageInfo<ResultRouteArgs>(name);
}

class ResultRouteArgs {
  const ResultRouteArgs({
    this.key,
    required this.shakeCount,
  });

  final Key? key;

  final int shakeCount;

  @override
  String toString() {
    return 'ResultRouteArgs{key: $key, shakeCount: $shakeCount}';
  }
}

/// generated route for
/// [TitleView]
class TitleRoute extends PageRouteInfo<void> {
  const TitleRoute({List<PageRouteInfo>? children})
      : super(
          TitleRoute.name,
          initialChildren: children,
        );

  static const String name = 'TitleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
