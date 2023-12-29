import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih_digital/get_storage.dart';
import 'package:tasbih_digital/model_tasbih.dart';
import 'package:tasbih_digital/utils_ui.dart';
import 'package:vibration/vibration.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _lastStopWatch = '00:00:00';
  String _startTasbih = '';
  late Stopwatch stopwatch;
  late Timer t;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      setState(() {
        _lastStopWatch = returnFormattedText();
      });
      stopwatch.reset();
      stopwatch.start();
    } else {
      stopwatch.start();
    }
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0"); // this one for the miliseconds
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0"); // this is for the second
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0"); // this is for the minute

    return "$minutes:$seconds:$milliseconds";
  }

  Color _colorStopWatch = Colors.black;
  List<ModelTasbih> _listTasbih = [];
  late ScrollController _scrollController;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == 1) {
        _startTasbih = DateTime.now().toString();
      }
      
      getBox.setCounter(_counter);
      Vibration.vibrate(duration: 100);
      handleStartStop();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) { setState(() {}); });

    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );

    var ambilTasbih = getBox.getTasbih();
    _counter = getBox.getCounter()!;

    if(ambilTasbih != ""){
      var list = json.decode(ambilTasbih.toString()) as List<dynamic>;
      for (var json in list) {
        _listTasbih.add(ModelTasbih(
            id: json['id'],
            judul: json['judul'],
            durasi: json['durasi'],
            kelompok: json['kelompok'],
            tasbih: json['tasbih'],
            tasbish_last: json['tasbish_last'],
            tassbih_start: json['tassbih_start'],
            tassbih_end: json['tassbih_end'])
        );
      }

    }

    logger.i('$_counter - ambiltasbih : $ambilTasbih');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(top: utilsUI.setHeight(40.0)),
              width: utilsUI.screenWidth(context),
              decoration: const BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
              child: Text(
                'بسم الله الرحمن الرحيم',
                style: TextStyle(color: Colors.white, fontSize: utilsUI.setSp(24.0)),
                textAlign: TextAlign.center,
              )),
          Container(
              width: utilsUI.screenWidth(context),
              height: utilsUI.setHeight(200.0),
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(25.0)),
              child:_listTasbih.length > 0 ?  GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                padding: const EdgeInsets.all(8.0), // padding around the grid
                itemCount: _listTasbih.length, // total number of items
                controller: _scrollController,
                itemBuilder: (context, index) {
                  var data = _listTasbih[index];
                  return Container(
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            data.judul.toString(),
                            style: TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: utilsUI.setWidth(2.0)),
                              child: Divider(color: Colors.white,)),
                          Text(
                            data.tasbih.toString(),
                            style: TextStyle(fontSize: 24.0, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ):Container(child: Center(child: Text('Dzikir Tersimpan Akan tampil disini',style: TextStyle(color: Colors.white),)),)),
          Container(
              width: utilsUI.screenWidth(context),
              height: utilsUI.setHeight(200.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(25.0)),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.only(left: utilsUI.setWidth(5.0)),
                        child: IconButton(
                          icon: Icon(Icons.save, color: Colors.white, size: utilsUI.setWidth(40.0)),
                          onPressed: () => _saveTasbih(),
                        ),
                      )),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.only(right: utilsUI.setWidth(5.0)),
                        child: IconButton(
                          icon: Icon(
                            Icons.restart_alt_sharp,
                            color: Colors.white,
                            size: utilsUI.setWidth(40.0),
                          ),
                          onPressed: () {
                            setState(() {
                              showAdaptiveDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog.adaptive(
                                  title: const Text('Reset'),
                                  content: const Text('Yakin Mau Reset ? '),
                                  actions: <Widget>[
                                    adaptiveAction(
                                      context: context,
                                      onPressed: () => Get.back(),
                                      child: const Text('Cancel'),
                                    ),
                                    adaptiveAction(
                                      context: context,
                                      onPressed: () {
                                        _resetTasbih();
                                        Get.back();
                                        },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        ),
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(right: utilsUI.setWidth(5.0)),
                        child: IconButton(
                          icon: Icon(
                            Icons.clear_all_rounded,
                            color: Colors.white,
                            size: utilsUI.setWidth(40.0),
                          ),
                          onPressed: () {
                            setState(() {
                              showAdaptiveDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog.adaptive(
                                  title: const Text('Hapus Semua'),
                                  content: const Text('Yakin Mau Hapus semua ? '),
                                  actions: <Widget>[
                                    adaptiveAction(
                                      context: context,
                                      onPressed: () => Get.back(),
                                      child: const Text('Cancel'),
                                    ),
                                    adaptiveAction(
                                      context: context,
                                      onPressed: () {
                                        _clearAll();
                                        Get.back();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: EdgeInsets.symmetric(vertical: utilsUI.setHeight(5.0), horizontal: utilsUI.setWidth(15.0)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.amber,
                        ),
                        child: Text(
                          _counter.toString(),
                          style: GoogleFonts.archivoBlack(color: Colors.black, fontSize: utilsUI.setSp(50.0)),
                          textAlign: TextAlign.right,
                        )),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if(_colorStopWatch == Colors.black){
                            _colorStopWatch = Colors.amber;
                          }else{
                            _colorStopWatch = Colors.black;
                          }

                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: utilsUI.setHeight(5.0), horizontal: utilsUI.setWidth(15.0)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.amber,
                          ),
                          child: Text(
                            _lastStopWatch,
                            style: GoogleFonts.archivoBlack(color: _colorStopWatch, fontSize: utilsUI.setSp(20.0)),
                            textAlign: TextAlign.right,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        stopwatch.stop();
                        stopwatch.reset();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                          height: utilsUI.setHeight(40.0),
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: utilsUI.setHeight(5.0), horizontal: utilsUI.setWidth(15.0)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.amber,
                          ),
                          child: Text(
                            returnFormattedText(),
                            style: GoogleFonts.archivoBlack(color: _colorStopWatch, fontSize: utilsUI.setSp(20.0)),
                            textAlign: TextAlign.right,
                          )),
                    ),
                  )
                ],
              )),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _incrementCounter();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(25.0)),
                height: utilsUI.screenHeight(context),
                width: utilsUI.screenWidth(context),
                child: Icon(
                  Icons.touch_app_outlined,
                  size: utilsUI.setWidth(200.0),
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  _saveTasbih() {
    setState(() {
      if(_counter != 0) {
        _listTasbih.add(ModelTasbih(
            id: _listTasbih.length,
            judul: (_listTasbih.length+1).toString(),
            durasi: '',
            kelompok: 'umum',
            tasbih: _counter,
            tasbish_last: _counter,
            tassbih_start: _startTasbih,
            tassbih_end: DateTime.now().toString()));
        getBox.setTasbih(json.encode(_listTasbih));
        _resetTasbih();
        _toEnd();
      }
    });
  }

  _resetTasbih() {
    setState(() {
      _counter = 0;
      _lastStopWatch = "00:00:00";
      stopwatch.stop();
      stopwatch.reset();
    });
  }

  void _toEnd() {
    try {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }catch(e){
      logger.e(e.toString());
    }
  }

  _clearAll() {
    setState(() {
      _listTasbih.clear();
      _resetTasbih();
      getBox.clear();
    });
  }
}


