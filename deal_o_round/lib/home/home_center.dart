import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import '../game/game_page.dart';
import '../game/game_widget.dart';
import '../game/logic/game_constants.dart';
import '../home/home_page.dart';
import '../services/size.dart';
import '../settings/settings_page.dart';
import 'title_line.dart';

class HomeCenter extends StatelessWidget {
  Widget _alertDialog() {
    final textStyle = TextStyle(fontSize: 18);
    return AlertDialog(
      title: Text('Game Services', style: textStyle),
      content: Text(
          'Without signing in the end score ' +
              'cannot be recorded and no achievement ' +
              'could be administered. ' +
              'Is it OK to continue?',
          style: textStyle),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes', style: textStyle),
          onPressed: () async {
            Get.close(1);
            await Get.to(GamePage(child: GameWidget()));
          },
        ),
        FlatButton(
            child: Text('No', style: textStyle),
            onPressed: () => Get.close(1) // Get.back(closeOverlays: true),
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = chipRadius(context); // ~40
    final size = context.mediaQuerySize;
    final buttonWidth = size.width / 3.8; // 210
    final bigSpacing = radius / 2; // ~20
    final spacing = bigSpacing / 2; // ~10
    final buttonPadding = EdgeInsets.all(spacing);
    final textStyle = TextStyle(
        fontSize: radius, fontFamily: 'Musicals', color: Colors.white);
    var buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.green.shade700, width: 3.0));
    final state = HomePage.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleLine(),
          SizedBox(height: bigSpacing),
          Row(children: <Widget>[
            Column(children: <Widget>[
              ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                      onPressed: () async {
                        if (UniversalPlatform.isAndroid ||
                            UniversalPlatform.isIOS) {
                          try {
                            await GamesServices.signIn().then((String result) {
                              state.updateSignedIn(true);
                            });
                          } catch (e) {
                            debugPrint("Error signing in: ${e.message}");
                            Get.snackbar("Error", "Could not sign in",
                                colorText: SB_TEXT, backgroundColor: SB_BACK);
                            state.updateSignedIn(false);
                          }
                        } else {
                          Get.snackbar(
                              "Sign In",
                              "Game Services is only available on Android " +
                                  "and Game Center is only available on iOS",
                              colorText: SB_TEXT,
                              backgroundColor: SB_BACK);
                        }
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: buttonShape,
                      padding: buttonPadding,
                      icon: Icon(Icons.person, size: radius),
                      label: Text("Login", style: textStyle))),
              SizedBox(height: spacing),
              ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                      onPressed: () async {
                        if (UniversalPlatform.isAndroid ||
                            UniversalPlatform.isIOS) {
                          if (state.gameSignedIn) {
                            try {
                              await GamesServices.showLeaderboards();
                              // iOS requires iOSLeaderboardID
                            } catch (e) {
                              debugPrint("Error showing lb: ${e.message}");
                              Get.snackbar("Error", "Could not fetch board",
                                  colorText: SB_TEXT, backgroundColor: SB_BACK);
                            }
                          } else {
                            Get.snackbar("Warning", "Sign-in needed",
                                colorText: SB_TEXT, backgroundColor: SB_BACK);
                          }
                        } else {
                          Get.snackbar("Leaderboards:",
                              "Only available on Android or iOS devices",
                              colorText: SB_TEXT, backgroundColor: SB_BACK);
                        }
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: buttonShape,
                      padding: buttonPadding,
                      icon: Icon(Icons.format_list_numbered, size: radius),
                      label: Text("Scores", style: textStyle))),
              SizedBox(height: spacing),
              ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                      onPressed: () async {
                        if (UniversalPlatform.isAndroid ||
                            UniversalPlatform.isIOS) {
                          if (state.gameSignedIn) {
                            try {
                              await GamesServices.showAchievements();
                            } catch (e) {
                              debugPrint("Error showing achievements: ${e.message}");
                              Get.snackbar("Error", "Could not fetch achievement",
                                  colorText: SB_TEXT, backgroundColor: SB_BACK);
                            }
                          } else {
                            Get.snackbar("Warning", "Sign-in needed",
                                colorText: SB_TEXT, backgroundColor: SB_BACK);
                          }
                        } else {
                          Get.snackbar("Achievements:",
                              "Only available on Android or iOS devices",
                              colorText: SB_TEXT, backgroundColor: SB_BACK);
                        }
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: buttonShape,
                      padding: buttonPadding,
                      icon: Icon(Icons.grade, size: radius),
                      label: Text("Grades", style: textStyle))),
            ]),
            SizedBox(width: spacing),
            Column(children: <Widget>[
              ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                      onPressed: () async {
                        if (!state.gameSignedIn &&
                            (UniversalPlatform.isAndroid ||
                                UniversalPlatform.isIOS)) {
                          await Get.dialog(_alertDialog(),
                              barrierDismissible: false);
                        } else {
                          await Get.to(GamePage(child: GameWidget()));
                        }
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: buttonShape,
                      padding: buttonPadding,
                      icon: Icon(Icons.play_arrow, size: radius),
                      label: Text("Play", style: textStyle))),
              SizedBox(height: spacing),
              ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                      onPressed: () => Get.to(SettingsPage()),
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: buttonShape,
                      padding: buttonPadding,
                      icon: Icon(Icons.settings, size: radius),
                      label: Text("Config", style: textStyle))),
              SizedBox(height: spacing),
              ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                      onPressed: () async => {
                            if (await canLaunch(HELP_URL))
                              {launch(HELP_URL)}
                            else
                              {
                                Get.snackbar("Attention", "Cannot open URL",
                                    colorText: SB_TEXT,
                                    backgroundColor: SB_BACK)
                              }
                          },
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: buttonShape,
                      padding: buttonPadding,
                      icon: Icon(Icons.help, size: radius),
                      label: Text("Help", style: textStyle))),
            ])
          ])
        ]);
  }
}
