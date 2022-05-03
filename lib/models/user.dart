class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  int? status;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.status});

//data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['secondName'],
      password: map['password'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': lastName,
      'password': password,
      'status': status,
    };
  }
}
