if [ $TERM=xterm ]
    then export TERM=xterm-256color
fi

export PS1="$(hostname -s):\$(pwd)# "
export TEXMFOUTPUT="/tmp"

alias cxx="c++ -L/usr/local/lib/ -I/usr/local/include/ -lgmp -lgmpxx"
alias cC="cc -L/usr/local/lib/ -I/usr/local/include -lgmp"
alias hs="ghc -O2"
alias ll="ls -lh"
alias la="ls -lhSr"

alias dt.int="date +%Y%m%d%H%M%S\ UTC%z"
alias dt.iny="date -u +%Y%m%d%H%M%S\ UTC"
alias dt.loc="date +%Y%m%d%H%M%S"
alias dt.nan="date +%Y%m%d.%H%M%S"

function venko() {
    ffmpeg -i "$1" -c:v libvpx-vp9 -c:a libopus -compression_level 10 -map_metadata 0 "$2"
    exiftool -TagsFromFile "$1" "$2"
}
