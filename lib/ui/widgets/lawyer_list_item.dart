import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/lawyer.dart';

class LawyerWidget extends StatefulWidget {
  final Lawyer lawyer;

  const LawyerWidget({Key? key, required this.lawyer, }) : super(key: key);

  @override
  State<LawyerWidget> createState() => _LawyerWidgetState();
}

class _LawyerWidgetState extends State<LawyerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            // child: SizedBox(
            //   height: 135,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.lawyer.data.logo![0],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.amber),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Expanded(
                          flex: 100,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 6, 6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.lawyer.title.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Specialization', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: const[
                                          Icon(Icons.location_on_outlined, color: Colors.amber, size: 15,),
                                          Text('Abu dhabi', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                          )
                        // ]
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.star, color: Colors.amber, size: 15.0),
                                Text('4.5', style: TextStyle(fontSize: 10.0))
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(Icons.visibility_outlined, color: Colors.amber, size: 15.0),
                                Text(' 500', style: TextStyle(fontSize: 10.0))
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(Icons.account_circle_outlined, color: Colors.amber, size: 15.0),
                                Text(' 40', style: TextStyle(fontSize: 10.0))
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(Icons.access_time, color: Colors.amber, size: 15.0),
                                Text(' Open', style: TextStyle(fontSize: 10.0))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      // ),
    );
  }
}
