#!/bin/ksh
ulimit -c 0

set -o vi

# EXPORTS --------------------------------------------------------------
export GITFLAGS="--word-diff=color --word-diff-regex=."

export PS1="\u@\h:\w\\$ "
export TEXMFOUTPUT=$TMPDIR
export HISTFILE=~/.ksh_history
export HISTSIZE=99999999
export FG_AIRCRAFT=~/.fgfs/aircraft-data

export PATH="$PATH:/usr/local/jdk-11/bin"
# | ni'o pilno le me la'oi .&&. co'e ki'u le su'u jitfa
# fa le du'u la .varik. cu co'e la'o zoi. go(1) .zoi. lo
# ro skami po la .varik.
which go 2> /dev/null > /dev/null && export PATH=$PATH:$(go env GOROOT)/bin:$(go env GOPATH)/bin

[ $TERM=xterm ] && export TERM=xterm-256color

# ALIASES --------------------------------------------------------------
alias cxx="c++ -Ofast -L/usr/local/lib/ -I/usr/local/include/ -lgmp -lgmpxx"
alias cC="cc -Ofast -L/usr/local/lib/ -I/usr/local/include -lgmp"
alias hs="ghc -O2"
alias ll="ls -lh"
alias la="ls -lhSr"
alias c="ssh -6YC"
alias ,n="ls -lh"

alias dt.int="date +%Y%m%d%H%M%S\ UTC%z"
alias dt.iny="date -u +%Y%m%d%H%M%S\ UTC"
alias dt.loc="date +%Y%m%d%H%M%S"
alias dt.nan="date +%Y%m%d.%H%M%S"

alias gs="git show \$GITFLAGS"
alias gd="git diff \$GITFLAGS"
alias gek="git commit -v"

alias cpy="rsync --progress --compress-level=6 -r"

alias nab="wget --restrict-file-names=windows -k --adjust-extension --span-hosts --convert-links --backup-converted --page-requisites"

# FUNCTIONS ------------------------------------------------------------
function ltx_internal {
	lualatex --draftmode "$1" &&
	bibtex "${1%.tex}";
	lualatex --draftmode "$1" &&
	lualatex "$1";

	# | ni'o xu cadga fa lo nu vimcu  .i ga je pilno
	# la'o zoi. ltx_internal .zoi. tu'a lo mulno noi
	# tu'a lo se vimcu cu na sarcu lo nu pilno ke'a
	for i in dvi log aux toc out bbl snm nav blg
	do
		rm "${1%.tex}.$i" &
	done;
}

function ltx {
	G="${1%.tex}.pdf";

	if test -e "$G"
	then
		if test "$(stat -f '%m' \"$G\")" -le "$(stat -f '%m' \"$1\")"
                then
			ltx_internal "$1";
		else
			echo "The file is aleady compiled, jack-ass.";
		fi
	else ltx_internal "$1";
	fi
}

function vtx {
	ltx "$1" && mupdf "${1%.tex}.pdf";
}

function venko {
    ffmpeg -i "$1" -c:v libaom-av1 -c:a libopus -compression_level 10 -map_metadata 0 "$2";
    exiftool -TagsFromFile "$1" "$2";
}

function guido {
	# | ni'o pilno ko'a goi la'o zoi. dd(1) .zoi. ki'u le
	# su'u ko'a me'oi .lazy.
	tr -dc A-Za-z0-9 < /dev/random | dd if=/dev/stdin of=/dev/stdout bs=1 "count=$1" status=none;
	echo "";
}

function lossyComp {
  TMP=$(mktemp -t $(yes X | head -n 32 | perl -0777pe 's/\n//g'));
  ffmpeg -f u8 -ar 11025 -i "$1" -q 0 "$TMP";
  ffmpeg -i "$TMP" -f u8 -ar 11025 "$1.compressed";
  rm "$TMP";
}

function ltxl {
	ltx "$1" &&
	git add "${1%.tex}.pdf" &&
	git commit -am "$2";
}
