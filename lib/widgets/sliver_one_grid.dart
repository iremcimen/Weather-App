import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliverOneGrid extends ConsumerWidget {
  const SliverOneGrid({
    super.key,
    required this.detailsList,
    this.titleList,
    this.icon,
    this.url,
    this.textButton,
    this.onTap,
  });

  final List<dynamic> detailsList;
  final List<dynamic>? titleList;
  final Icon? icon;
  final String? url;
  final TextButton? textButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: Colors.transparent,
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: detailsList.length,
                        separatorBuilder: (_, __) =>
                            const Divider(thickness: 1, height: 12),
                        itemBuilder: (context, index) {
                          final title =
                              (titleList != null && index < titleList!.length)
                              ? titleList![index]?.toString()
                              : null;
                          final detail = detailsList[index]?.toString() ?? '';
                          return Row(
                            children: [
                              if (title != null)
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.blueGrey.shade800,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  detail,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (textButton != null) textButton!,
                      if (icon != null)
                        Align(alignment: Alignment.center, child: icon),
                      if (url != null)
                        Image.network(
                          url!,
                          fit: BoxFit.contain,
                          width: 60,
                          height: 60,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.cloud_outlined,
                            color: Colors.blue.shade300,
                            size: 40,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
