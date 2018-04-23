import 'package:flutter/material.dart';

ShoppingList getInstance() {
  return new ShoppingList(
    product: <Product>[
      new Product(name: 'Eggs'),
      new Product(name: 'Flour'),
      new Product(name: 'Chocolate chips'),
      new Product(name: 'Eggs'),
      new Product(name: 'Flour'),
      new Product(name: 'Chocolate chips'),
    ],
  );
}

class Product {
  const Product({this.name});

  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

/**
 * 无状态的
 */
class ShoppingListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }

  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black45 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black45,
      decoration: TextDecoration.lineThrough,
    );
  }
}

/**
 * 可变状态
 */
class ShoppingList extends StatefulWidget {
  final List<Product> product;

  ShoppingList({Key key, this.product}) : super(key: key);

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

/**
 * 继承State 时一般类写成私有的 _ 标识私有的
 */
class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingList = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingList.add(product);
      } else {
        _shoppingList.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.product.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingList.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
