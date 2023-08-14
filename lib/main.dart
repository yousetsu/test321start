import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountdownScreen(),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // アニメーションが完了したら"START!"を表示
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("START!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Countdown Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 3, 2, 1 のカウントダウンを表示するアニメーション
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                int count = (3 - (_controller.value * 3)).ceil();
                if (count == 0) {
                  return Text(
                    "START!",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  );
                } else {
                  return Text(
                    count.toString(),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
