import 'package:flutter/material.dart';
import 'dart:math' as math;

class Sliverpage extends StatefulWidget{

  @override
  State createState() => _SliverPage();
}

class _SliverPage extends State<Sliverpage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(   // 스크롤에 따라 높이가 달라지거나 다른 위젯 위에 표시되도록 스크롤뷰에 통합
            expandedHeight: 150.0,  // 앱바의 높이 설정
            flexibleSpace: FlexibleSpaceBar(  // SliverAppBar 공간에 어떤 위젯을 만들지 설정
              title: Text('Sliver Example'),
              background: Image.asset('images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            pinned: true,
          ),
          SliverPersistentHeader(
              delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text('list 숫자', style: TextStyle(fontSize: 30),),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ),
                )
              ),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
          ])),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('그리드 숫자', style: TextStyle(fontSize: 30),),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                  ),
                )
            ),
            pinned: true,
          ),
          SliverGrid(
              delegate: SliverChildListDelegate([
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index){
                return Container(
                  child: customCard('list count : $index'),
                );
              }, childCount: 10)
          )
        ],
      ),
    );
  }

  Widget customCard(String text){
    return Card(
      child: Container(
        height: 120,
        child: Center(
          child: Text(text, style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate{
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate){
    return maxHeight != oldDelegate.maxHeight ||
    minHeight != oldDelegate.minHeight ||
    child != oldDelegate.child;
  }
}