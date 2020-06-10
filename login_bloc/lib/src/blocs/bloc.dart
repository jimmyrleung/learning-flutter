import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

// in the course, 'with' without extends do not work
// so if that not works, use class Bloc extends Object with Validatorss
class Bloc with Validators {
  // Make sure that our stream controller's deal with strings
  // underscores make properties 'private'
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Retrieve data from stream - Getters
  // Notice that we return the transformed stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  // When we get a valid email and a valid password, this function will return true
  // If needed, we could combine the email and the password, but in this case we just want
  // both of them valid
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  // Change data - Getters
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email: $validEmail');
    print('Password: $validPassword');
  }

  // Sinks remain open until we manually close them
  // So it's a good practice to always define a dispose method
  // inside a class that use streams
  dispose() { 
    _email.close();
    _password.close();
  } 
}

// This works like a singleton: wherever you import that file,
// you will only have access to that instance of Bloc instead of
// the Bloc class
final bloc = Bloc();