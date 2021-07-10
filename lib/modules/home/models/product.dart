class Product {
  final int id;
  final int categoryId;
  final String categoryName;
  final String ean;
  final String imageUri;
  final String name;
  final String description;
  final int createdAt;
  final int updatedAt;
  final int order;

  Product(this.id, this.categoryId, this.categoryName, this.ean, this.imageUri,
      this.name, this.description, this.createdAt, this.updatedAt, this.order);

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryId = json['categoryId'],
        categoryName = json['categoryName'],
        ean = json['ean'],
        imageUri = json['imageUri'],
        name = json['name'],
        description = json['description'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        order = json['order'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'categoryId': this.categoryId,
        'categoryName': this.categoryName,
        'ean': this.ean,
        'imageUri': this.imageUri,
        'name': this.name,
        'description': this.description,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'order': this.order,
      };
}
