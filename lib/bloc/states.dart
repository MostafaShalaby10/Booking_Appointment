abstract class States{
}
class InitialState extends States{}

class LoadingLogin extends States{}
class SuccessfulLogin extends States{}
class ErrorLogin extends States{
  final String? error ;
  ErrorLogin({ required this.error});
}

class LoadingInsertDoctor extends States{}
class SuccessfulInsertDoctor extends States{}
class ErrorInsertDoctor extends States{
  final String? error ;
  ErrorInsertDoctor({required this.error});
}

class LoadingRegister extends States{}
class SuccessfulRegister extends States{}
class ErrorRegister extends States{
  final String? error ;
  ErrorRegister({required this.error});
}

class LoadingGetSpecialization extends States{}
class SuccessGetSpecialization extends States{}
class ErrorGetSpecialization extends States{}


class LoadingBooking extends States{}
class SuccessBooking extends States{}
class ErrorBooking extends States{}

class LoadingGetAllPatients extends States{}
class SuccessGetAllPatients extends States{}
class ErrorGetAllPatients extends States{}
