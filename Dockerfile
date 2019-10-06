FROM ubuntu:18.04

RUN apt-get update && \
    apt-get autoclean

RUN apt-get update && apt-get install \
  -y --no-install-recommends python3 python3-virtualenv

ENV USERNAME=qt_user
RUN useradd $USERNAME && mkdir /home/$USERNAME && chown -R $USERNAME:users /home/$USERNAME

WORKDIR /home/$USERNAME

ENV VIRTUAL_ENV=/home/$USERNAME/venv
RUN python3 -m virtualenv --python=/usr/bin/python3 $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install -r requirements.txt

RUN apt-get install -y --no-install-recommends \
        libegl1-mesa \
        libgl1-mesa-dri \
        x11-xserver-utils \
        libxkbcommon-x11-0 \
        x11-utils \
        libnss3 \
        libasound2

# multimedia
RUN apt-get install -y --no-install-recommends \
        libgstreamer1.0-0 \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-libav \
        gstreamer1.0-doc \
        gstreamer1.0-tools \
        libpulse-mainloop-glib0 \
        alsa-base \
        alsa-utils \
        pulseaudio

USER $USERNAME

# setup virtual display
ENV DISPLAY=:99
ENV SCREEN=0
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
ENV XDG_RUNTIME_DIR=/run/user/1000

# turn this on for verbose qt feedback
ENV QT_DEBUG_PLUGINS=0
ENV QT_VERBOSE true
ENV QT_TESTING true

# Run the application:
COPY app /home/$USERNAME
CMD ["python", "main.py"]