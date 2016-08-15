#!/bin/bash

OUTFILE="manifest.lua"

echo "return {" > "$OUTFILE"

find . -type f -name "*-manifest.lua" | while read manifest; do
	echo -e "\t[\"$(basename "$manifest" "-manifest.lua")\"] = \"$(basename $manifest ".lua")\"," >> "$OUTFILE"
done

echo "}" >> "$OUTFILE"

