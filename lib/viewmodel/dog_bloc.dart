import 'dart:async';
import 'dart:convert';

import 'package:template/model/dog_image_model.dart';
import 'package:template/repository/dog_image_repository.dart';

enum OperationType {
  fetch,
  delete,
}

class CounterBloc {
  DogRepository _dogRepository = DogRepository();
  final StreamController<DogImageModel> _stateStreamController =
      StreamController<DogImageModel>();
  final StreamController<OperationType> _eventStreanController =
      StreamController<OperationType>();

  StreamSink<DogImageModel> get imageSink => _stateStreamController.sink;
  Stream<DogImageModel> get imageStream => _stateStreamController.stream;
  StreamSink<OperationType> get eventSink => _eventStreanController.sink;
  Stream<OperationType> get eventStrean => _eventStreanController.stream;
  CounterBloc() {
    eventStrean.listen((event) async {
      if (event == OperationType.fetch) {
        try {
          var imageData = await _dogRepository.fetchDogImage();
          if (imageData.isSuccess()) {
            var data = jsonEncode(imageData.getValue());
            var tempdata = dogImageModelFromJson(data);
            imageSink.add(tempdata);
          } else
            imageSink.addError("somthing went worng");
        } catch (e) {
          imageSink.addError("Somthing went worng");
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreanController.close();
  }
}
