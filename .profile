ulimit -c 0

# VI mode is a bit weird at first but works pretty well.
set -o vi

# EXPORTS --------------------------------------------------------------
export GITFLAGS="--word-diff=color --word-diff-regex=."

export PS1="\u@\h:\w\\$ "
export TEXMFOUTPUT="/tmp"
export HISTFILE=~/.ksh_history
export HISTSIZE=99999999
export FG_AIRCRAFT=~/.fgfs/aircraft-data

export PATH="$PATH:/usr/local/jdk-11/bin"
export PATH="$PATH:/root/.cabal/bin"
export PATH=$PATH:$(go env GOROOT)/bin:$(go env GOPATH)/bin

if [ $TERM=xterm ]
	then export TERM=xterm-256color
fi

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

alias gs="git show $GITFLAGS"
alias gd="git diff $GITFLAGS"

alias cpy="rsync --progress --compress-level=6 -r"

alias vex='vim -e'

# FUNCTIONS ------------------------------------------------------------
function ltx_internal {
	lualatex --draftmode $1 && (
		bibtex ${1%.tex};
		lualatex --draftmode $1 &&
		lualatex $1;
	);

	for i in dvi log aux toc out bbl snm nav blg
	do
		rm ${1%.tex}.$i &
	done;
}

function ltx {
	G=${1%.tex}.pdf;

	if test -e $G
	then
		if test $(stat -f '%m' $G) -le $(stat -f '%m' $1)
                then
			ltx_internal $1;
		else
			echo "The file is aleady compiled, jack-ass.";
		fi
	else ltx_internal $1;
	fi
}

function vtx {
	ltx $1 &&
	mupdf ${1%.tex}.pdf;
}

function venko {
    ffmpeg -i "$1" -c:v libaom-av1 -c:a libopus -compression_level 10 -map_metadata 0 "$2";
    exiftool -TagsFromFile "$1" "$2";
}

function guido {
	tr -dc A-Za-z0-9 < /dev/random | dd if=/dev/stdin of=/dev/stdout bs=1 count=$1 status=none;
	echo "";
}

function lossyComp {
  TMP=/tmp/`head /dev/random | tr -dc A-Za-z0-9 | cut -c 1-32`.opus;
  ffmpeg -f u8 -ar 11025 -i $1 -q 0 $TMP;
  ffmpeg -i $TMP -f u8 -ar 11025 $1.compressed;
  rm $TMP;
}

alias nab="wget --restrict-file-names=windows -k --adjust-extension --span-hosts --convert-links --backup-converted --page-requisites"

function ltxl {
	ltx $1 &&
	git add $1 ${1%.tex}.pdf &&
	git commit -am "$2";
}
