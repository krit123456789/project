import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:project/Material_picking.dart';
import 'package:project/Model/categorymodel.dart';
import 'package:project/Model/productmodel.dart';
import 'package:project/myConstant.dart';
import 'package:project/select_supplies.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<CategoryModel> categories = [];
  List<CategoryModel> list = [];
  String type = '1';
  List<String> types = ['1', '2', '3', '4'];
  int indexsource = 0;
  bool status = true;
  List<Color> colors = [
    Color(0xFF4c1130),
    Color(0xFFA64D79),
    Color(0xFFF493F6),
    Color(0xFFD5A6BD)
  ];
  int bColors = 0;
  final TextEditingController search = TextEditingController();

  // STT
  String voiceText = '';
  final RecorderStream _recorder = RecorderStream();
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    // STT
    _recorder.initialize();
  }

  // Start Section STT
  void streamingRecognize() async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });

    await _recorder.start();

    setState(() {
      recognizing = true;
    });
    final serviceAccount = ServiceAccount.fromString((await rootBundle
        .loadString('assets/cssupplyproject-c8f0ab04c3bf.json')));
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();

    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream!);

    var responseText = '';

    responseStream.listen((data) {
      final currentText =
          data.results.map((e) => e.alternatives.first.transcript).join('\n');

      if (data.results.first.isFinal) {
        responseText += '\n' + currentText;
        setState(() {
          text = responseText;
          recognizeFinished = true;
        });
      } else {
        setState(() {
          text = responseText + '\n' + currentText;
          recognizeFinished = true;
        });
      }
    }, onDone: () {
      setState(() {
        recognizing = false;
      });
    });
  }

  void stopRecording() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    setState(() {
      recognizing = false;
    });
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'th-TH');
  // End Section STT

  void searchSupply(String value) {
    list = categories.where((element) {
      final title = element.category_name.toLowerCase();
      final search = value.toLowerCase();
      return title.contains(search);
    }).toList();
    setState(() {});
  }

  Future getData() async {
    if (categories.isNotEmpty) {
      categories.clear();
    }
    String path = '${MyConstant.domain}/api_nont_demo/getAllCategory.php';
    await Dio().get(path).then((value) {
      if (value.toString() != "null") {
        for (var item in json.decode(value.data)) {
          CategoryModel model = CategoryModel.fromMap(item);
          categories.add(model);
        }
        list = categories;
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Search by voice
    if (recognizeFinished) {
      voiceText = text.trim();
      search.text = voiceText;
      search.selection = TextSelection.collapsed(offset: voiceText.length);
      searchSupply(voiceText);
    }

    return Scaffold(
      backgroundColor: Color(0xFFd2bad6),
      appBar: AppBar(
        backgroundColor: Color(0xFF4c1130),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context)),
      ),
      // body: Items(),
      body: status
          ? CircularProgressIndicator()
          : Column(
              children: [
                Text(
                  "ประเภทวัสดุ",
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                /* Container(
                  width: 40.w,
                  child: DropdownButton(
                    isExpanded: true,
                    value: type,
                    items: types.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        indexsource = 0;
                        type = value as String;
                      });
                      getName(value as String);
                    },
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                      controller: search,
                      onChanged: (value) {
                        setState(() {
                          voiceText = value;
                        });
                        searchSupply(value);
                      },
                      decoration: InputDecoration(
                        hintText: "ค้นหา",
                        prefixIcon: Icon(Icons.search),
                      )),
                ),
                /*if (recognizeFinished)
                  _RecognizeContent(
                    text: text,
                  ),*/
                ElevatedButton(
                  onPressed: recognizing ? stopRecording : streamingRecognize,
                  child: recognizing
                      ? const Text('Stop recording')
                      : const Text('Start Streaming from mic'),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 240, childAspectRatio: 18 / 6),
                    itemBuilder: (context, index) =>
                        Items(context, list[index], index),
                  ),
                ),
              ],
            ),
    );
  }

  /* DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
          "${item} ${indexsource == sources.length - 1 ? '' : sources[indexsource++]}"),
    );
  }*/

  Widget Items(BuildContext context, CategoryModel categoryModel, int index) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectSupplies(
                    id: categoryModel.category_id,
                  ))),
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color(0xFF4c1130), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(8.0)),
            Text(
              "${categoryModel.category_name}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// STT
class _RecognizeContent extends StatelessWidget {
  final String? text;

  const _RecognizeContent({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Text(
            'The text recognized by the Google Speech Api:',
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            text ?? '---',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
