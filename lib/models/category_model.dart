const String categoryId = "id";
const String categoryName = "name";
const String categoryAvailable = "available";

class CategoryModel {
  String? catId;
  String? catName;
  bool available;

  CategoryModel({
    this.catId,
    this.catName,
    this.available = true,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      categoryId: catId,
      categoryName: catName,
      categoryAvailable : available,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
    catId: map[categoryId],
    catName: map[categoryName],
    available : map[categoryAvailable],

  );
}