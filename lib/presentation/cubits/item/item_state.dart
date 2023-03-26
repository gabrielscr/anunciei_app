import 'package:equatable/equatable.dart';

import '../../../domain/entities/item.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class LoadingItemState extends ItemState {
  const LoadingItemState();
}

class LoadedItemState extends ItemState {
  final List<Item> items;

  const LoadedItemState(this.items);

  @override
  List<Object?> get props => [items];
}

class ErrorItemState extends ItemState {
  final String message;

  const ErrorItemState(this.message);

  @override
  List<Object?> get props => [message];
}
