class Bloglist {
  final int id;
  final String title;
  final String subtitle;
  final String slug;
  final String description;
  final String category_id;
  final String date;

  const Bloglist(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.slug,
      required this.description,
      required this.category_id,
      required this.date,
      });

  static Bloglist fromJson(json) {
    return Bloglist(
        id: json['id'],
        title: json['title'],
        subtitle: json['sub_title'],
        slug: json['slug'],
        description: json['description'],
        category_id: json['category_id'],
        date: json['date'],
        
        );
  }
}