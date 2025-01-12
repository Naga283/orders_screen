// Events
abstract class FileDialogEvent {}

class OpenDialogEvent extends FileDialogEvent {}

class CloseDialogEvent extends FileDialogEvent {}

class SelectFilesEvent extends FileDialogEvent {}

class UploadFilesEvent extends FileDialogEvent {}
