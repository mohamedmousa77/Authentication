// ignore_for_file: file_names

class ProviderModel {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String whatsAppNumber;
  final String cityID;
  final String aereaID;
  String type;

  ProviderModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.cityID,
    required this.aereaID,
    this.type = 'service_owner',
  });

  factory ProviderModel.fromJson(Map<String, dynamic> data) {
    return ProviderModel(
      name: data['full_name'],
      email: data['email'],
      password: data['password'],
      phoneNumber: data['phone'],
      whatsAppNumber: data['whatsapp_number'],
      cityID: data['city_id'],
      aereaID: data['area_id'],
      type: 'service_owner',
    );
  }
}
