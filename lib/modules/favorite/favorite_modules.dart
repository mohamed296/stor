import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/favorites_data_model.dart';
import 'package:stor/shared/provider/cubit.dart';
import 'package:stor/shared/provider/state.dart';

class FavoriteMedules extends StatelessWidget {
  const FavoriteMedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorCubit, StorState>(
      listener: (context, state) {},
      builder: (context, state) {
        StorCubit cubit = StorCubit.get(context);
        return state is! FavoritProdctLodingState
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return prodctItem(
                      cubit.fDModel!.data!.data[index], cubit, context);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
                itemCount: cubit.fDModel!.data!.data.length)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget prodctItem(Data model, StorCubit cubit, context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.product!.image.toString()),
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  model.product!.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Text(
                      " ${model.product!.price}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    if (model.product!.oldPrice != 0 &&
                        model.product!.oldPrice != model.product!.price)
                      Text(
                        " ${model.product!.oldPrice}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {
                      cubit.changeFavorit(model.product!.id!);
                    },
                    icon: cubit.isFavorit[model.product!.id] != null &&
                            cubit.isFavorit[model.product!.id] == true
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                            size: 35,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            size: 35,
                          )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
