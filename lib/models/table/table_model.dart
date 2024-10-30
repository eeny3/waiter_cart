class TableModel {
  final int id;

  final bool isAvailable;

  TableModel({
    required this.id,
    required this.isAvailable,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'isAvailable': isAvailable ? 1 : 0,
      };

  static TableModel fromMap(Map<String, dynamic> map) => TableModel(
        id: map['id'],
        isAvailable: map['isAvailable'] == 1,
      );
}
