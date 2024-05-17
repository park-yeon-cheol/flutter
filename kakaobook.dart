import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp>{
  String result = '';
  List? data;
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();

    _scrollController!.addListener((){
      if(_scrollController!.offset >= _scrollController!.position.maxScrollExtent && !_scrollController!.position.outOfRange){
        print('bottom');
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
        child: Center(
          child: data!.length ==0?
          Text('데이터가 없습니다.', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,):
              ListView.builder(itemBuilder: (context, index){
                return Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          data![index]['thumbnail'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                data![index]['title'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('저자 : ${data![index]['authors'].toString()}'),
                            Text('가격 : ${data![index]['sale_price'].toString()}'),
                            Text('판매중 : ${data![index]['status'].toString()}'),
                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                );
              },
              itemCount: data!.length,
              controller: _scrollController
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          page = 1;
          data!.clear();
          getJSONData();
        },
        child: Icon(Icons.file_download),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text('$page'),
      ),
    );
  }

  Future<String> getJSONData() async{
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(url),
      headers: {"Authorization": "KakaoAK {}"}
      );
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}