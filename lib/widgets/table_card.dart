import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final Color prefixColor;
  final Icon prefixIcon;
  final String label;

  const TableCard({
    super.key,
    required this.prefixColor,
    required this.label,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: const EdgeInsets.all(4),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffFFFEFF),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: prefixColor,
            ),
            height: double.maxFinite,
            child: prefixIcon,
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Center(
              child: Text(
                label,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
