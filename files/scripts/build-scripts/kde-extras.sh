#!/usr/bin/env bash

#
# This script mass builds multiple plasma, kwin and other types of extensions for the wuzetka image.
#
# Plasma Panel Colorizer ~ https://github.com/luisbocanegra/plasma-panel-colorizer
# Burn My Windows dependencies ~ https://github.com/Schneegans/Burn-My-Windows
# Overview Widget for Plasma ~ https://github.com/HimDek/Overview-Widget-for-Plasma
# Latte Separator ~ https://github.com/doncsugar/applet-latte-separator
# Window Title Applet ~ https://github.com/dhruv8sh/plasma6-window-title-applet
# plasma-applet-netspeed-widget ~ https://github.com/dfaust/plasma-applet-netspeed-widget
# PlasMusic Toolbar ~ https://github.com/ccatterina/plasmusic-toolbar
# Desktop Indicator for Plasma 6 ~ https://github.com/dhruv8sh/plasma6-desktop-indicator
# Syncthing Tray ~ https://github.com/Martchus/syncthingtray


# Tell build process to exit if there are any errors.
set -euo pipefail

# Create directory where all compiled things go into
mkdir -p /artifacts/kde-extras-built

#
# Dependencies
#
dnf install -y git gcc-c++ cmake gn perl-YAML-LibYAML ninja-build git-clang-format clang-devel libdrm extra-cmake-modules glibc-gconv-extra gettext boost-devel qt5-qttools-devel kwin-devel kf6-kconfigwidgets-devel libepoxy-devel kf6-kcmutils-devel qt6-qtbase-private-devel wayland-devel libplasma-devel plasma5support-devel kf6-kwidgetsaddons-devel zip unzip "cmake(Plasma)" "cmake(KF5Config)" "cmake(KF5CoreAddons)" "cmake(KF5FrameworkIntegration)"  "cmake(KF5GuiAddons)" "cmake(KF5Kirigami2)" "cmake(KF5WindowSystem)" "cmake(KF5I18n)" "cmake(Qt5DBus)" "cmake(Qt5Quick)" "cmake(Qt5Widgets)" "cmake(Qt5X11Extras)" "cmake(KDecoration2)" "cmake(KF6ColorScheme)" "cmake(KF6Config)" "cmake(KF6KIO)" "cmake(KF6CoreAddons)" "cmake(KF6FrameworkIntegration)" "cmake(KF6GuiAddons)" "cmake(KF6I18n)" "cmake(KF6KCMUtils)" "cmake(KF6KirigamiPlatform)" "cmake(KF6WindowSystem)" "cmake(Qt6Core)" "cmake(Qt6DBus)" "cmake(Qt6Quick)" "cmake(Qt6QuickControls2)" "cmake(Qt6Svg)" "cmake(Qt6Widgets)" "cmake(Qt6Xml)" "cmake(Qt6Concurrent)" "cmake(Qt6Gui)" "cmake(Qt6LinguistTools)" "cmake(Qt6Network)" "cmake(Qt6Qml)" "cmake(Qt6Test)" "cmake(Qt6WebEngineWidgets)"

# Directories
mkdir -p /artifacts/kde-extras-built/usr/share/kwin/effects
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoid

#
# Burn My Windows
#
#cd /tmp
#git clone --single-branch --depth=1 https://github.com/Schneegans/Burn-My-Windows.git
#cd Burn-My-Windows/kwin
#chmod +x build.sh
#./build.sh
#tar -zvxf burn_my_windows_kwin4.tar.gz -C /artifacts/kde-extras-built/usr/share/kwin/effects --no-same-owner --no-same-permissions

#
# Smart Video Wallpaper Reborn
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/wallpapers/luisbocanegra.smart.video.wallpaper.reborn
cd /tmp
git clone https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn.git
cd plasma-smart-video-wallpaper-reborn
sed -i 's@~/.local@/artifacts/kde-extras-built/usr@g' /tmp/plasma-smart-video-wallpaper-reborn/install.sh
chmod +x install.sh
./install.sh

#
# Plasma Panel Colorizer
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer
cd /tmp
git clone --single-branch --depth=1 https://github.com/luisbocanegra/plasma-panel-colorizer.git
cd plasma-panel-colorizer
chmod +x package-plasmoid.sh
./package-plasmoid.sh
unzip plasmoid-panel-colorizer-v*.plasmoid -d /artifacts/kde-extras-built/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer

#
# Compact Pager
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.github.tilorenz.compact_pager
cd /tmp
git clone https://github.com/tilorenz/compact_pager.git
cd compact_pager
chmod +x bundle.sh
./bundle.sh
unzip package.plasmoid -d /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.github.tilorenz.compact_pager

#
# Overview Widget
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.himdek.kde.plasma.overview
cd /tmp
git clone https://github.com/HimDek/Overview-Widget-for-Plasma.git
cd Overview-Widget-for-Plasma
make overview
unzip overview.plasmoid -d /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.himdek.kde.plasma.overview

#
# Latte Separator
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator
cd /tmp
git clone https://github.com/doncsugar/applet-latte-separator.git -b plasma6
cd applet-latte-separator
mv contents /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator
mv LICENSE /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator
mv metadata.json /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.latte.separator

#
# Window Title Applet
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle
cd /tmp
git clone https://github.com/dhruv8sh/plasma6-window-title-applet.git
cd plasma6-window-title-applet
mv contents /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle
mv LICENSE /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle
mv metadata.json /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.windowtitle

#
# plasma-applet-netspeed-widget
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.netspeedWidget
cd /tmp
git clone https://github.com/dfaust/plasma-applet-netspeed-widget.git
cd plasma-applet-netspeed-widget
mv ./package/* /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.netspeedWidget

#
# PlasMusic Toolbar
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/plasmusic-toolbar
cd /tmp
git clone https://github.com/ccatterina/plasmusic-toolbar.git
cd plasmusic-toolbar
mv ./src/* /artifacts/kde-extras-built/usr/share/plasma/plasmoids/plasmusic-toolbar

#
# Desktop Indicator
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
cd /tmp
git clone https://github.com/dhruv8sh/plasma6-desktop-indicator.git
cd plasma6-desktop-indicator
mv contents /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
mv LICENSE /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator
mv metadata.json /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.plasm6desktopindicator

#
# Ginti
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.ginti
cd /tmp
git clone https://github.com/dhruv8sh/plasma6-desktopindicator-gnome.git
cd plasma6-desktopindicator-gnome
mv contents /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.ginti
mv LICENSE /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.ginti
mv metadata.json /artifacts/kde-extras-built/usr/share/plasma/plasmoids/org.kde.plasma.ginti

#
# Web Browser Extended
#
mkdir -p /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.hourui.plasma.webbrowser
cd /tmp
git clone https://github.com/Hou-Rui/web-browser-extended.git
cd web-browser-extended
mv contents /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.hourui.plasma.webbrowser
mv LICENSE /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.hourui.plasma.webbrowser
mv metadata.json /artifacts/kde-extras-built/usr/share/plasma/plasmoids/com.hourui.plasma.webbrowser

#
# Syncthing Tray
#
mkdir -p /tmp/syncthingtray-building/sources
cd /tmp/syncthingtray-building/sources
git clone https://github.com/Martchus/cpp-utilities.git c++utilities
git clone https://github.com/Martchus/qtutilities.git
git clone https://github.com/Martchus/qtforkawesome.git
git clone https://github.com/ForkAwesome/Fork-Awesome.git forkawesome
git clone https://github.com/Martchus/syncthingtray.git
git clone https://github.com/Martchus/subdirs.git
ls /tmp/syncthingtray-building/sources
cd /tmp/syncthingtray-building
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="/usr" -DQT_PACKAGE_PREFIX:STRING='Qt6' -DKF_PACKAGE_PREFIX:STRING='KF6' -DFORK_AWESOME_FONT_FILE="/tmp/syncthingtray-building/sources/forkawesome/fonts/forkawesome-webfont.woff2" -DFORK_AWESOME_ICON_DEFINITIONS="/tmp/syncthingtray-building/sources/forkawesome/src/icons/icons.yml" "/tmp/syncthingtray-building/sources/subdirs/syncthingtray"
ls /tmp/syncthingtray-building
DESTDIR="/artifacts/kde-extras-built" ninja install
ls /tmp/syncthingtray-building
ls /artifacts/kde-extras-built

#
# Show all files, hopefully
#
ls /artifacts/kde-extras-built
ls /artifacts/kde-extras-built/usr