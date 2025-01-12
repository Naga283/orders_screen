// States
import 'package:file_picker/file_picker.dart';

// States
abstract class FileDialogState {
  final List<PlatformFile> selectedFiles;
  final List<PlatformFile> uploadedFiles;
  final bool isUploadEnabled;

  FileDialogState(this.selectedFiles, this.uploadedFiles, this.isUploadEnabled);
}

class FileDialogInitial extends FileDialogState {
  FileDialogInitial() : super([], [], false);
}

class FileDialogOpened extends FileDialogState {
  FileDialogOpened(
      List<PlatformFile> selectedFiles, List<PlatformFile> uploadedFiles)
      : super(selectedFiles, uploadedFiles, selectedFiles.isNotEmpty);
}

class FileDialogClosed extends FileDialogState {
  FileDialogClosed(List<PlatformFile> uploadedFiles)
      : super([], uploadedFiles, false);
}
