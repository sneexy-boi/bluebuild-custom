ARG IMAGE_MAJOR_VERSION=42

# KDE/Kwin Extras/Addons
FROM fedora:${IMAGE_MAJOR_VERSION} as kde-extras

COPY files/scripts/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/kde-extras.sh && \
    /tmp/build-scripts/kde-extras.sh

# Joystickwake
#FROM fedora:${IMAGE_MAJOR_VERSION} as joystickwake
#
#COPY config/scripts/build-scripts /tmp/build-scripts
#
#RUN chmod +x /tmp/build-scripts/joystickwake.sh && \
#    /tmp/build-scripts/joystickwake.sh

# Catppuccin
FROM fedora:${IMAGE_MAJOR_VERSION} as catppuccin

# GTK Theme
COPY files/scripts/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/catppuccin-gtk.sh && \
    /tmp/build-scripts/catppuccin-gtk.sh

# Packages built with cargo/rust
FROM fedora:${IMAGE_MAJOR_VERSION} as cargo

COPY files/scripts/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/cargo.sh && \
    /tmp/build-scripts/cargo.sh

# Packages built with go
FROM fedora:${IMAGE_MAJOR_VERSION} as go

COPY files/scripts/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/go.sh && \
    /tmp/build-scripts/go.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr
RUN mkdir -p /artifacts/etc

COPY --from=go /tmp/go-built/usr /artifacts/usr
COPY --from=cargo /tmp/cargo-built/usr /artifacts/usr
COPY --from=catppuccin /tmp/catppuccin-gtk/usr /artifacts/usr
COPY --from=catppuccin /tmp/catppuccin-gtk/etc /artifacts/etc
COPY --from=kde-extras /tmp/kde-extras-built/usr /artifacts/usr
