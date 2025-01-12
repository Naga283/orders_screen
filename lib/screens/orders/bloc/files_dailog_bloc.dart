// BLoC
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/files_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/file_dailog_state.dart';

// BLoC
class FileDialogBloc extends Bloc<FileDialogEvent, FileDialogState> {
  FileDialogBloc() : super(FileDialogInitial()) {
    on<OpenDialogEvent>((event, emit) {
      emit(FileDialogOpened(state.selectedFiles, state.uploadedFiles));
    });

    on<CloseDialogEvent>((event, emit) {
      emit(FileDialogClosed(state.uploadedFiles));
    });

    on<SelectFilesEvent>((event, emit) async {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.media,
      );
      if (result != null) {
        emit(FileDialogOpened(result.files, state.uploadedFiles));
      }
    });

    on<UploadFilesEvent>((event, emit) {
      emit(FileDialogClosed(state.selectedFiles));
    });
  }
}