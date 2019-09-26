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
$SED -i '/subsection{temp/I,$d' sections/constraints.tex
$SED -i '/{Outline/I,$d' sections/intro.tex
$SED -i '/sect:analysis/d' sections/intro.tex
$SED -i -E '/newtheorem.*?(theorem|lemma|definition)/d' macros.tex
$SED -i '/\label{sect:introduction}.*/a \\\input{delta/preintro}' sections/intro.tex
$SED -i 's/details in Section~\\ref{sect:analysis}/the following sections/g' sections/model.tex
find sections/ -type f -exec $SED -i -E 's@(includegraphics.*?\{)fig/@\1@g' '{}' \;
find sections/ -type f -exec $SED -i -E 's@(includegraphics.*?\{)@\1fig/@g' '{}' \;

echo "[*] list of manual fixes needed to exclude analysis:"
ag --ignore 'sections/analysis.tex' 'sect:analysis' sections/
