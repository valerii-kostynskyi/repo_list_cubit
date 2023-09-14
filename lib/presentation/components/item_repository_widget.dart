import 'package:flutter/material.dart';
import 'package:repo_list_cubit/data/model/repository_model.dart';
import 'package:repo_list_cubit/presentation/components/svg_icon_widget.dart';

class ItemRepositoryWidget extends StatelessWidget {
  final RepositoryModel repository;
  final Function()? onIconTap;
  final Function()? onTap;

  const ItemRepositoryWidget({
    Key? key,
    required this.repository,
    required this.onIconTap,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Hero(
        tag: 'item_${repository.id}',
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            repository.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Text(
                            repository.description,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SVGIconWidget(
                          onTap: onIconTap,
                          icon: 'icon_star',
                          color: repository.isFavorite
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: Hero(
  //       tag: 'item_${repository.id}',
  //       child: Material(
  //         child: ListTile(
  //             onTap: onTap,
  //             title: Text(
  //               repository.name,
  //               style: Theme.of(context).textTheme.bodyMedium,
  //             ),
  //             subtitle: Text(
  //               repository.description,
  //               maxLines: 2,
  //               style: Theme.of(context).textTheme.bodySmall,
  //             ),
  //             trailing: SizedBox(
  //               width: 30,
  //               height: 30,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SVGIconWidget(
  //                     onTap: onIconTap,
  //                     icon: 'icon_star',
  //                     color: repository.isFavorite
  //                         ? Theme.of(context).colorScheme.primary
  //                         : Theme.of(context).colorScheme.onSecondary,
  //                   ),
  //                 ],
  //               ),
  //             )),
  //       ),
  //     ),
  //   );
  // }
}
