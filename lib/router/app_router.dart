import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterkaigi_2025_booth_game/title_view.dart';
import 'package:flutterkaigi_2025_booth_game/game_view.dart';
import 'package:flutterkaigi_2025_booth_game/result_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TitleRoute.page, path: '/', initial: true),
    AutoRoute(page: GameRoute.page, path: '/game'),
    AutoRoute(page: ResultRoute.page, path: '/result'),
  ];
}
