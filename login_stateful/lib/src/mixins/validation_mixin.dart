class ValidationMixin {
  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid e-mail.';
    }

    // null indicates that the field is valid - it can be omitted
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Password must have at least 4 characters.';
    }

    return null;
  }
}
