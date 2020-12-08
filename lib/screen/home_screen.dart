import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:alan_voice/alan_voice.dart';

import '../model/radio.dart';
import '../utils/utils.dart';
import '../apikey.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Variables
  List<Radios> _radios;
  Radios _selectedRadio;
  Color _selectedRadioColor;
  var _isPlaying = false;
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    _fetchRadio();
    _isRadioPlaying();
    alanVoiceButton();
    super.initState();
  }

  void _fetchRadio() async {
    final radioJson = await rootBundle.loadString('assets/radio.json');
    _radios = RadioList.fromJson(radioJson).radios;
    _selectedRadio = _radios[0];
    print(_radios);
    setState(() {});
  }

  void _playMusic(String url) {
    _audioPlayer.play(url);
    _selectedRadio = _radios.firstWhere((radio) => radio.url == url);
    // setState(() {});
    print(_selectedRadio);
  }

  void _isRadioPlaying() {
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  void alanVoiceButton() {
    AlanVoice.addButton("$apiKey/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => assistantCommand(command.data));
  }

  void assistantCommand(Map<String, Object> response) {
    switch (response['command']) {
      case 'play':
        _playMusic(_selectedRadio.url);
        break;
      default:
    }
  }

  IconData _playingIcon(int index) {
    if (_isPlaying) {
      if (_radios[index].id == _selectedRadio.id) {
        return CupertinoIcons.pause;
      }
    }
    return CupertinoIcons.play;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AIColors.primaryColor,
                  _selectedRadioColor ?? AIColors.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(8.0),
            child: AppBar(
              title: Text(
                'AI Radio',
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          _radios == null
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ))
              : CarouselSlider.builder(
                  itemCount: _radios.length,
                  itemBuilder: (context, index) {
                    final rad = _radios[index];
                    return InkWell(
                      onTap: () {
                        if (_isPlaying) {
                          _audioPlayer.stop();
                          if (_selectedRadio.id != rad.id) {
                            _selectedRadioColor =
                                Color(int.tryParse(_radios[index].color));
                            _playMusic(rad.url);
                          }
                        } else {
                          _playMusic(rad.url);
                          _selectedRadioColor = Color(
                            int.tryParse(_radios[index].color),
                          );
                          setState(() {});
                        }
                      },
                      child: Container(
                        // margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 4.0,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          image: rad.image == null
                              ? CircularProgressIndicator(
                                  value: 50,
                                  backgroundColor: Colors.white,
                                )
                              : DecorationImage(
                                  image: NetworkImage(rad.image),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken,
                                  )),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    rad.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  Text(
                                    rad.tagline,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                _playingIcon(index),
                                color: Colors.white,
                                size: 50.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      _selectedRadio = _radios[index];
                      // _selectedRadioColor = Color(
                      //   int.tryParse(_radios[index].color),
                      // );
                      // setState(() {});
                    },
                  ),
                )
        ],
      ),
    );
  }
}
