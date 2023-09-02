class UserModel {
  dynamic id;
  dynamic email;
  dynamic name;
  dynamic department;
  dynamic employeeId;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.department,
    required this.employeeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      department: json["department"],
      employeeId: json["employee_id"],
    );
  }
}
