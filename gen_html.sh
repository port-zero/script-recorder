OUTFILE=outfile.ansi
OUTFILE_HTML=outfile.html
ansifilter-1.7/src/ansifilter -H "$OUTFILE" > "$OUTFILE_HTML"

sed -ie 's/<pre\([^>]*\)>/<div\1>/g' "$OUTFILE_HTML"
sed -ie 's/<\/pre>/<\/div>/g' "$OUTFILE_HTML"

sed -ie 's/COMMAND&gt;&gt;&gt;\(.*\)&lt;&lt;&lt;COMMAND/<div class="command-line">\1<\/div>/g' "$OUTFILE_HTML"
sed -ie 's/COMMAND_CONTINUATION&gt;&gt;&gt;\(.*\)&lt;&lt;&lt;COMMAND_CONTINUATION/<div class="command-line continuation">\1<\/div>/g' "$OUTFILE_HTML"
sed -ie 's/RESPONSE&gt;&gt;&gt;/<div class="response">/g' "$OUTFILE_HTML"
sed -ie 's/&lt;&lt;&lt;RESPONSE/<\/div>/g' "$OUTFILE_HTML"
sed -ie 's/<\/head>/<link rel="stylesheet" href="bootstrap.css"><\/link><\/head>/g' "$OUTFILE_HTML"
sed -ie 's/<\/head>/<link rel="stylesheet" href="style.css"><\/link><\/head>/g' "$OUTFILE_HTML"

