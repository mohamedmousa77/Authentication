// ignore_for_file: file_names

class CustomerModel {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  String type;

  CustomerModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.type = 'customer',
  });

  factory CustomerModel.fromJson(Map<String, dynamic> data) {
    return CustomerModel(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      phoneNumber: data['phoneNumber'],
      type: 'customer',
    );
  }
}
