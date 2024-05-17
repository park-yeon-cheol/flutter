import 'package:flutter/cupertino.dart';
import 'animalItem.dart';

class CupertinoSecondPage extends StatefulWidget{
  final List<Animal>? animalList;
  const CupertinoSecondPage({Key? key, required this.animalList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CupertinoSecondPage();
  }
}

class _CupertinoSecondPage extends State<CupertinoSecondPage>{
  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _flytExist = false;
  String? _imagePath;

  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text('양서류', textAlign: TextAlign.center),
      width: 80,
    ),
    1: SizedBox(
      child: Text('포유류', textAlign: TextAlign.center),
      width: 80,
    ),
    3: SizedBox(
      child: Text('파충류', textAlign: TextAlign.center),
      width: 80,
    )
  };


  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('동물 추가'),
      ),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(0),
                  child: CupertinoTextField(
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                  ),
              ),
              CupertinoSegmentedControl(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  groupValue: _kindChoice,
                  children: segmentWidgets,
                  onValueChanged: (int value){
                    setState(() {
                      _kindChoice = value;
                    });
                  }),
              Row(
                children: <Widget>[
                  Text('날개가 존재합니까?'),
                  CupertinoSwitch(
                      value: _flytExist,
                      onChanged: (value){
                        setState(() {
                          _flytExist = value;
                        });
                      })
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset('images/cow.png', width: 80),
                      onTap: (){
                        _imagePath = 'images/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('images/pig.png', width: 80),
                      onTap: (){
                        _imagePath = 'images/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('images/bee.png', width: 80),
                      onTap: (){
                        _imagePath = 'images/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('images/cat.png', width: 80),
                      onTap: (){
                        _imagePath = 'images/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('images/fox.png', width: 80),
                      onTap: (){
                        _imagePath = 'images/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('images/monkey.png', width: 80),
                      onTap: (){
                        _imagePath = 'images/monkey.png';
                      },
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                  child: Text('동물 추가하기'),
                  onPressed: (){
                    widget.animalList?.add(Animal(
                      animalName: _textController?.value.text,
                      kind: getKind(_kindChoice),
                      imagePath: _imagePath,
                      flyExist: _flytExist
                    ));
                  })
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
  getKind(int radioValue){
    switch(radioValue){
      case 0:
        return '양서류';
      case 1:
        return '파충류';
      case 2:
        return '포유류';
    }
  }
}