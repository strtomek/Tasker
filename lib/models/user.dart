class User {
  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  List<String> projecList;

  User(
      {this.id,
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.projecList});

  User.fromMap(Map snapshot, String id) {
    id = id;
    email = snapshot['email'] ?? '';
    firstName = snapshot['firstName'] ?? '';
    lastName = snapshot['lastName'] ?? '';
    projecList = snapshot['channelList'] ?? [];
  }

  toJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
