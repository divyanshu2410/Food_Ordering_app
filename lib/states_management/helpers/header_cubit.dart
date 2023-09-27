import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/models/header.dart';

class HeaderCubit extends Cubit<Header> {
  HeaderCubit() : super(Header('', ''));

  update(String title, String imageUrl) => emit(Header(title, imageUrl));
}
