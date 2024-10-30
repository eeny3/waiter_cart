class OrderModel {
  final int? id;

  final int tableId;

  OrderModel({
    required this.id,
    required this.tableId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'tableId': tableId,
      };

  static OrderModel fromMap(Map<String, dynamic> map) => OrderModel(
        id: map['id'],
        tableId: map['tableId'],
      );
}
