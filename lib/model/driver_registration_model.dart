class RegistrationModel {
  final String firstName;
  final String lastName;
  final String imagePath;

  RegistrationModel({
    required this.firstName,
    required this.lastName,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'imagePath': imagePath,
    };
  }
}
