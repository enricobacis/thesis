#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ITYT="$DIR/../../../ityt/paper"

if [ -x "$(command -v gsed)" ]; then
    SED=gsed
else
    SED=sed
fi

echo "[*] Removing old files"
rm -rf fig bib sections macros.tex

echo "[*] Copying new files from repo"
cp -r $ITYT/{fig,bib,sections} ./
cat $ITYT/macros/macros.tex > macros.tex

echo "[*] (article,paper) -> chapter"
export LC_CTYPE=C
export LANG=C
find sections/ -type f -exec $SED -i -E 's/(article|paper)/chapter/g' '{}' \;

echo "[*] Fixing latex"
$SED -i 's/\bnewcommand\b/declarecommand/g' macros.tex
$SED -i '/theoremstyle/d' macros.tex
$SED -i '/subsection{temp}/,$d' sections/constraints.tex
$SED -i -E '/newtheorem.*?(theorem|lemma|definition)/d' macros.tex
find sections/ -type f -exec $SED -i -E '/\\(DF|df|EB|eb|MG|mg|MR|mr|SP|sp|todo|proposal|drop|copied)\{.*?\}/d' '{}' \;
find sections/ -type f -exec $SED -i -E 's@(includegraphics.*?\{)fig/@\1@g' '{}' \;
find sections/ -type f -exec $SED -i -E 's@(includegraphics.*?\{)@\1fig/@g' '{}' \;

ag 'sect:analysis'
