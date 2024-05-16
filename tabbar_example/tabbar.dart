import 'package:flutter/material.dart';
import 'firstPage.dart';
import 'secondPage.dart';
import 'animalItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  TabController? controller;
  List<Animal> animalList = new List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBaar Example'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(list: animalList),
          SecondApp()],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
        Tab(icon: Icon(Icons.looks_two, color: Colors.blue),)
      ], controller: controller,)
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(animalName: "벌", kind: "곤충", imagePath: "images/bee.png"));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "images/cat.png"));
    animalList.add(Animal(animalName: "젖소", kind: "포유류", imagePath: "images/cow.png"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "images/dog.png"));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "images/fox.png"));
    animalList.add(Animal(animalName: "원숭이", kind: "영장류", imagePath: "images/monkey.png"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "images/pig.png"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류", imagePath: "images/wolf.png"));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
