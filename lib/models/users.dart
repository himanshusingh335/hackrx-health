class Users {
  String name = "";
  String mail = "";
  String role = "";
  String id = "";

  Users({
    required this.id,
    required this.name,
    required this.role,
    required this.mail,
  });

  bool isDoctor() {
    bool isDoctor = false;
    if (role == "Doctor") {
      isDoctor = true;
    }
    return isDoctor;
  }
}
