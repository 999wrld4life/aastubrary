import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfviewerScreen extends StatefulWidget {
  final String? pdfPath;
  const PdfviewerScreen({super.key, required this.pdfPath});

  @override
  State<PdfviewerScreen> createState() => _PdfviewerScreenState();
}

class _PdfviewerScreenState extends State<PdfviewerScreen> {
  late PdfControllerPinch pdfControllerPinch;
  int totalPages = 0;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    pdfControllerPinch =
        PdfControllerPinch(document: PdfDocument.openAsset(widget.pdfPath!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Total Pages: $totalPages'),
                IconButton(
                  onPressed: () {
                    pdfControllerPinch.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Text('Page: $currentPage'),
                IconButton(
                  onPressed: () {
                    pdfControllerPinch.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  },
                  icon: const Icon(Icons.arrow_forward),
                )
              ],
            ),
            Expanded(
              child: PdfViewPinch(
                controller: pdfControllerPinch,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                onDocumentError: (error) {
                  print(error.toString());
                },
                onDocumentLoaded: (document) {
                  setState(() {
                    totalPages = document.pagesCount;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
