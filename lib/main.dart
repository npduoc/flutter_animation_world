import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var dropDownList = [
    'bounceIn',
    'flash',
    'pulse',
    'rubberBand',
    'shakex',
    'shakey'
  ];
  late String dropdownValue;
  late AnimationController _animationController;
  double _scale = 1;
  final durationBounce = const Duration(milliseconds: 200);

  void _onPressed() {
    print('onPressed');
    // if (dropdownValue == dropDownList[0]) {
      _animationController.forward();
      Future.delayed(durationBounce, () {
        _animationController.reverse();
      });
    // }
  }

  @override
  void initState() {
    dropdownValue = dropDownList[0];
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 0.2,
        duration: durationBounce)
      ..addListener(() {
        setState(() {

        });
        if (_animationController.isCompleted) {
          _animationController.repeat();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _onPressed,
              child: Transform.scale(
                scale: _scale,
                child: const Text(
                  'ANIMATION',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _dropDown()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.circle),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _dropDown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: dropDownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
