import 'package:anunciei_app/core/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/item/item_cubit.dart';
import '../cubits/item/item_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCubit>(
      create: (context) => getIt<ItemCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Clean Architecture Example'),
        ),
        body: BlocConsumer<ItemCubit, ItemState>(
          listener: (context, state) {
            if (state is ErrorItemState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, items) {
            return _buildBody(context, items);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getIt<ItemCubit>().loadItems();
          },
          tooltip: 'Fetch Items',
          child: const Icon(Icons.download),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ItemState state) {
    if (state is LoadingItemState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LoadedItemState) {
      return ListView.builder(
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('ID: ${item.id}'),
          );
        },
      );
    } else if (state is ErrorItemState) {
      return Center(
        child: Text(
          'Error: ${state.message}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
