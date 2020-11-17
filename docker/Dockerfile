FROM python:3.8.6-slim-buster

RUN apt-get update -y   \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq \
    cargo               \
    git                 \
    libglu1-mesa        \
    libgtk2.0-0         \
    libxcb-icccm4       \
    libxcb-image0       \
    libxcb-keysyms1     \
    libxcb-randr0       \
    libxcb-render-util0 \
    libxcb-render0      \
    libxcb-shm0         \
    libxcb-xfixes0      \
    libxcb-xinerama0    \
    libxcb-xkb1         \
    libxkbcommon-x11-dev \
    libxkbcommon0       \
    libxcb-xkb1         \
    libxcb-shape0       \
    libyaml-dev         \
    make                \
    scons               \
 && rm -rf /var/lib/apt/lists/*

RUN python3.8 -m pip install --upgrade pip

RUN python3.8 -m pip install    \
    Cython                      \
    numpy                       \
    PySide2                     \
    PyYAML                      \
    QDarkStyle

RUN cargo install --root /opt/cargo --git https://github.com/cmbrandenburg/ips-patch.git

RUN cd /opt/            \
 && git clone https://github.com/camsaul/nesasm.git \
 && cd nesasm/source    \
 && make                \
 && make install

ENV PATH="/opt/cargo/bin:${PATH}"
