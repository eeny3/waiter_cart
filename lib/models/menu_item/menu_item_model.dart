class MenuItemModel {
  final int id;

  final String name;

  final double price;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
  };

  static MenuItemModel fromMap(Map<String, dynamic> map) => MenuItemModel(
    id: map['id'],
    name: map['name'],
    price: map['price'],
  );
}
