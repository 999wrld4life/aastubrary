class Book {
  final String title;
  final String imagePath;
  final String? pdfPath;
  final String author;
  final String description;
  final double rating;

  Book(
      {required this.title,
      required this.imagePath,
      this.pdfPath,
      required this.author,
      required this.rating,
      required this.description});

  Book copyWith(String? title, String? imagePath, String? pdfPath,
      String? author, String? description, double? rating) {
    return Book(
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      pdfPath: pdfPath ?? this.pdfPath,
      author: author ?? this.author,
      description: description ?? this.description,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePath': imagePath,
      'pdfPath': pdfPath,
      'author': author,
      'description': description,
      'rating': rating,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      imagePath: json["imagePath"],
      pdfPath: json['p'],
      author: json['author'] as String,
      description: json['description'] as String,
      rating: json['rating'] as double,
    );
  }
  @override
  String toString() {
    return 'Book(title: $title, author: $author, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Book) return false;
    return title == other.title && author == other.author;
  }

  @override
  int get hashCode => Object.hash(title, author);
}
