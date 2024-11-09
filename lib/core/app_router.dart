import 'package:auto_route/auto_route.dart';
import 'package:youfirst/app_wrapper.dart';
import 'package:youfirst/view/authentication/login/login_view.dart';
import 'package:youfirst/view/authentication/signup/sigup_view.dart';
import 'package:youfirst/view/home/home_view.dart';
import 'package:youfirst/view/question/question_view.dart';
import 'package:youfirst/view/speech_to_text/speech_to_text_example.dart';
import 'package:youfirst/view/therapy/therapy_view.dart';
part './app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SigupRoute.page),
        // AutoRoute(page: HomeRoute.page, initial: false),
        // AutoRoute(page: QuestionRoute.page),
        // AutoRoute(page: TherapyRoute.page, initial: false),
        AutoRoute(page: AppScaffold.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: TherapyRoute.page),
          AutoRoute(page: QuestionRoute.page),
        ]),
      ];
}
