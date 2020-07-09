import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'title_line.dart';

class HomeCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const aboutUrl = "http://dealoround.com/about.html";
    const helpUrl = "http://dealoround.com/help.html";
    const size = 40.0;
    const buttonWidth = 210.0;
    const buttonPadding = const EdgeInsets.all(10.0);
    const spacing = 10.0;
    const textStyle = TextStyle(
      fontSize: size,
      fontFamily: 'Musicals',
      color: Colors.white
    );
    var buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Colors.green.shade700, width: 3.0)
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TitleLine(),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                    onPressed: () => {
                      debugPrint('Login!')
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: buttonShape,
                    padding: buttonPadding,
                    icon: Icon(Icons.person, size: size),
                    label: Text("Login", style: textStyle)
                  )
                ),
                SizedBox(height: spacing),
                ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                    onPressed: () => {
                      debugPrint('Scores!')
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: buttonShape,
                    padding: buttonPadding,
                    icon: Icon(Icons.format_list_numbered, size: size),
                    label: Text("Scores", style: textStyle)
                  )
                ),
                SizedBox(height: spacing),
                ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                    onPressed: () => {
                      debugPrint('Settings!')
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: buttonShape,
                    padding: buttonPadding,
                    icon: Icon(Icons.settings, size: size),
                    label: Text("Config", style: textStyle)
                  )
                )
              ]
            ),
            SizedBox(width: spacing),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                    onPressed: () => {
                      debugPrint('Play!')
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: buttonShape,
                    padding: buttonPadding,
                    icon: Icon(Icons.play_arrow, size: size),
                    label: Text("Play", style: textStyle)
                  )
                ),
                SizedBox(height: spacing),
                ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                    onPressed: () async => {
                      if (await canLaunch(aboutUrl)) {
                        launch(aboutUrl)
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Cannot open URL')
                        ))
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: buttonShape,
                    padding: buttonPadding,
                    icon: Icon(Icons.info, size: size),
                    label: Text("About", style: textStyle)
                  )
                ),
                SizedBox(height: spacing),
                ButtonTheme(
                  minWidth: buttonWidth,
                  child: RaisedButton.icon(
                    onPressed: () async => {
                      if (await canLaunch(helpUrl)) {
                        launch(helpUrl)
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Cannot open URL')
                        ))
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: buttonShape,
                    padding: buttonPadding,
                    icon: Icon(Icons.help, size: size),
                    label: Text("Help", style: textStyle)
                  )
                )
              ]
            )
          ]
        )
      ]
    );
  }
}
