class Product {
  final int? id;
  final String name;
  final double price;
  final double gstPercentage;
  final String? description;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.gstPercentage,
    this.description,
  });

  double get cgst => (price * gstPercentage / 200);
  double get sgst => (price * gstPercentage / 200);
  double get totalPrice => price + cgst + sgst;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'gstPercentage': gstPercentage,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      gstPercentage: (json['gstPercentage'] as num).toDouble(),
      description: json['description'] as String?,
    );
  }

  Product copyWith({
    int? id,
    String? name,
    double? price,
    double? gstPercentage,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      gstPercentage: gstPercentage ?? this.gstPercentage,
      description: description ?? this.description,
    );
  }
}
