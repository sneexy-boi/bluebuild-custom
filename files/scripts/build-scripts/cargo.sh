#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Dependency and folder
dnf install -y git gcc gcc-c++ cmake openssl protobuf protobuf-devel protobuf-compiler openssl-devel dbus-devel pkgconf-pkg-config rust-rustix-devel rustup cargo
mkdir -p /artifacts/cargo-built/usr/bin

# Atuin - https://github.com/atuinsh/atuin
#cargo install atuin --root /artifacts/cargo-built/usr
cd /tmp
git clone https://github.com/atuinsh/atuin.git
cd atuin/crates/atuin
cargo install --path . --root /artifacts/cargo-built/usr

# Starship - https://starship.rs/
cargo install starship --locked --root /artifacts/cargo-built/usr

# Sheldon - https://github.com/rossmacarthur/sheldon
cargo install sheldon --root /artifacts/cargo-built/usr

# sd - https://github.com/chmln/sd.git
cargo install sd --root /artifacts/cargo-built/usr

# Krabby - https://github.com/yannjor/krabby
cargo install krabby --root /artifacts/cargo-built/usr

# inori - https://github.com/eshrh/inori
cargo install inori --root /artifacts/cargo-built/usr

# Rusty Music Player Client - https://github.com/mierak/rmpc
cargo install rmpc --locked --root /artifacts/cargo-built/usr

# MPD Discord RPC - https://github.com/JakeStanger/mpd-discord-rpc
cargo install mpd-discord-rpc --locked --root /artifacts/cargo-built/usr

# Rescrobbled - https://github.com/InputUsername/rescrobbled
cargo install rescrobbled --root /artifacts/cargo-built/usr

# tlrc - https://github.com/tldr-pages/tlrc
cargo install tlrc --locked --root /artifacts/cargo-built/usr

# emoji-gen - https://activitypub.software/Amelia/emoji-gen
cd /tmp
git clone https://git.gay/sneexy/emoji-gen.git
cd emoji-gen
cargo install --path . --root /artifacts/cargo-built/usr