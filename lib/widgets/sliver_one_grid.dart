import 'package:flutter/material.dart';

class SliverOneGrid extends StatelessWidget {
  const SliverOneGrid({
    super.key,
    required this.detailsList,
    this.titleList,
    this.icon,
    this.url,
  });

  final List detailsList;
  final List? titleList;
  final Icon? icon;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                          const Divider(thickness: 1, height: 20),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            if (titleList != null)
                              Text(
                                titleList![index],
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Colors.blueGrey.shade800,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                detailsList[index],
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
                if (icon != null)
                  Align(alignment: Alignment.center, child: icon),
                if (url != null)
                  Image.network(
                    url!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.cloud_outlined,
                      color: Colors.blue.shade300,
                      size: 40,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
