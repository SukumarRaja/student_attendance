class AttendanceModel {
  final String id;
  final String date;
  final String checkIn;
  final String checkOut;
  final String createdAt;

  AttendanceModel(
      {required this.id,
      required this.date,
      required this.checkIn,
      required this.checkOut,
      required this.createdAt});

  factory AttendanceModel.fromJson(Map<String, dynamic> data) {
    return AttendanceModel(
        id: data['employee_id'],
        date: data['date'],
        checkIn: data['check_in'] ?? "",
        checkOut: data['check_out'] ?? "",
        createdAt: data['created_at']);
  }
}
