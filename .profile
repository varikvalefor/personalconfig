export PS1="$(hostname -s):\$(pwd)# "
export TEXMFOUTPUT="/tmp"

alias cxx="c++ -L/usr/local/lib/ -I/usr/local/include/ -lgmp -lgmpxx"
alias cC="cc -L/usr/local/lib/ -I/usr/local/include -lgmp"
alias hs="ghc -O2"
alias ll="ls -lh"
alias la="ls -lhSr"

function venko() {
    ffmpeg -i "$1" -c:v libvpx-vp9 -c:a libopus -compression_level 10 -map_metadata 0 "$2"
    exiftool -TagsFromFile "$1" "$2"
}
