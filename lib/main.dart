import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './raisedButtonState.dart' as raisedButtonState;
import './ShoppingListItem.dart' as ShoppingList;
import './CookBook_Theme.dart' as MyTheme;

void main() => runApp(MyTheme.getInstance()); // => 单行函数活方法的简短手段

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('点击了我');
      },
      child: new Container(
        height: 36.0,
        width: 40.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          color: Colors.lightGreen[50],
        ),
        child: new Center(
          child: new Text('点击'),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ListView',
      //设置主题
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: ShoppingList.getInstance(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  /**
   * 添加交互 （点击事件）
   */
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ListView'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("收藏的数据"),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);
    return new ListTile(
        title: new Text(
          suggestion.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          //在右边添加了一个小心
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          //在Flutter的反应风格框架中，调用setState()触发器调用build()State对象的方法，
          //从而导致对UI的更新
          setState(() {
            if (alreadySaved) {
              _saved.remove(suggestion);
            } else {
              _saved.add(suggestion);
            }
          });
        });
  }
}
