#!/bin/bash

OUTFILE="manifest.lua"

echo "return {" > "$OUTFILE"

find . -type f -name "*-manifest.lua" | while read manifest; do
	modname="$(echo $manifest | cut -d '-' -f 1)"
	echo -e "\t[\"$(basename $modname)\"] = \"$(basename $modname)\"," >> "$OUTFILE"
done

echo "}" >> "$OUTFILE"

