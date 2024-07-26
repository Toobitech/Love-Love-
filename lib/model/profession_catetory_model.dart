class ProfessionCategory {
  int id;
  String name;
  String slug;
  int status;
  String? createdAt;
  String? updatedAt;

  ProfessionCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfessionCategory.fromJson(Map<String, dynamic> json) {
    return ProfessionCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
