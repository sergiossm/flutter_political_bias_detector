import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({
    Key key,
    @required this.title,
    @required this.desc,
    @required this.svgSrc,
    @required this.percentage,
    @required this.selected,
  }) : super(key: key);

  final String title, desc, svgSrc;
  final double percentage;
  final bool selected;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: defaultPadding),
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primaryColor.withOpacity(selected ? 1 : 0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(svgSrc),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      desc,
                      style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Text('${percentage.toStringAsFixed(2)}%')
          ],
        ),
      );
}
