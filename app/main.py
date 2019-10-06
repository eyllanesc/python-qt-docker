import os

from PyQt5 import (
    QtCore,
    QtGui,
    QtWidgets,
    QtWebEngineWidgets,
    QtMultimedia,
    QtMultimediaWidgets,
)

current_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(current_dir, "resources")


class Widget(QtWidgets.QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        le = QtWidgets.QLineEdit()

        view = QtWebEngineWidgets.QWebEngineView()
        view.load(QtCore.QUrl("https://www.youtube.com/"))

        video_filename = os.path.join(resources_dir, "big_buck_bunny_720p_30mb.mp4")
        player = QtMultimedia.QMediaPlayer(self)
        player.setMedia(
            QtMultimedia.QMediaContent(QtCore.QUrl.fromLocalFile(video_filename))
        )
        videowidget = QtMultimediaWidgets.QVideoWidget()
        player.setVideoOutput(videowidget)
        player.play()

        lay = QtWidgets.QVBoxLayout(self)
        lay.addWidget(le)
        lay.addWidget(view, stretch=1)
        lay.addWidget(videowidget, stretch=1)
        self.resize(640, 480)


def main(args):
    app = QtWidgets.QApplication(args)

    w = Widget()
    w.show()

    ret = app.exec_()
    return ret


if __name__ == "__main__":
    import sys

    sys.exit(main(sys.argv))
