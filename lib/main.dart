import 'package:deleteanimation/widget/shopping_item_widget.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'model/shopping_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'AnimatedList';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Colors.deepPurple,
    ),
    home: MainPage(title: title),
  );
}

class MainPage extends StatefulWidget {
  final String title;
  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  final key = GlobalKey<AnimatedListState>();
  final items = List.from(Data.shoppingList);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.deepPurple,
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: key,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) =>
                buildItem(items[index], index, animation),
          ),
        ),
      ],
    ),
  );

  Widget buildItem(item, int index, Animation<double> animation) =>
      ShoppingItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );

  void removeItem(int index) {
    final item = items.removeAt(index);

    key.currentState?.removeItem(
      index,
          (context, animation) => buildItem(item, index, animation),
    );
  }
}