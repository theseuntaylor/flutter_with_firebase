enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

enum SignInStatus {
  success,
  invalidEmail,
  unknownException,
  userNotFound,
  wrongPassword,
  emailUnverified
}