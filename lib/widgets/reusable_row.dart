import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  //**
  final String title, value;

  const ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 8.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'poppins_bold',
                  color: Colors.white60,
                  fontSize: 15.0,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'poppins_bold',
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
