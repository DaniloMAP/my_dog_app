class DogImage {
  final String id;
  final String url;
  final String breedName;

  DogImage({required this.id, required this.url, required this.breedName});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    final breeds = (json['breeds'] as List<dynamic>?) ?? [];
    final name =
        breeds.isNotEmpty ? (breeds[0]['name'] as String) : 'Sem informação de raça';
    return DogImage(
      id: json['id'] as String,
      url: json['url'] as String,
      breedName: name,
    );
  }
}
